package com.example.demo.controller;

import com.example.demo.model.User; // Correct import for your User model
import com.example.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

// Updated to Jakarta imports for Spring Boot 3.x
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import java.util.Map;
import java.util.HashMap;

@Controller
public class HomeController {

    @Autowired
    private UserService userService;

    // Login page - GET request
    @GetMapping("/")
    public String home() {
        return "login";
    }

    @GetMapping("/login")
    public String showLoginPage(Model model, HttpSession session) {
        // If user is already logged in, redirect to dashboard
        if (session.getAttribute("loggedInUser") != null) {
            String role = (String) session.getAttribute("userRole");
            return "redirect:/" + getRoleDashboard(role);
        }
        return "login";
    }

    // Login form submission - POST request
    @PostMapping("/login")
    public String processLogin(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam("role") String role,
            @RequestParam(value = "rememberMe", required = false) String rememberMe,
            HttpSession session,
            HttpServletResponse response,
            RedirectAttributes redirectAttributes,
            Model model) {

        try {
            // Validate input
            if (username == null || username.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Username is required");
                return "redirect:/login";
            }

            if (password == null || password.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Password is required");
                return "redirect:/login";
            }

            if (role == null || role.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Please select your role");
                return "redirect:/login";
            }

            // Authenticate user
            User user = userService.authenticateUser(username.trim(), password, role);

            if (user != null) {
                // Check if user role matches selected role
                if (!user.getRole().equalsIgnoreCase(role)) {
                    redirectAttributes.addFlashAttribute("error",
                            "Invalid role selection for this account");
                    return "redirect:/login";
                }

                // Check if user account is active
                if (!user.isActive()) {
                    redirectAttributes.addFlashAttribute("error",
                            "Your account has been deactivated. Please contact administrator.");
                    return "redirect:/login";
                }

                // Successful login - create session
                session.setAttribute("loggedInUser", user);
                session.setAttribute("userId", user.getId());
                session.setAttribute("username", user.getUsername());
                session.setAttribute("userRole", user.getRole());
                session.setAttribute("fullName", user.getFullName());
                session.setAttribute("email", user.getEmail());
                session.setAttribute("firstName", user.getFirstName());
                session.setAttribute("lastName", user.getLastName());
                session.setAttribute("loginTime", System.currentTimeMillis());

                // Handle "Remember Me" functionality
                if ("on".equals(rememberMe)) {
                    Cookie userCookie = new Cookie("rememberedUser", username);
                    userCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
                    userCookie.setPath("/");
                    response.addCookie(userCookie);

                    Cookie roleCookie = new Cookie("rememberedRole", role);
                    roleCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
                    roleCookie.setPath("/");
                    response.addCookie(roleCookie);
                }

                // Update last login time
                userService.updateLastLogin(user.getId());

                // Redirect to appropriate dashboard based on role
                String dashboardUrl = getRoleDashboard(user.getRole());
                redirectAttributes.addFlashAttribute("success",
                        "Welcome back, " + user.getFullName() + "!");

                return "redirect:/" + dashboardUrl;

            } else {
                // Authentication failed
                redirectAttributes.addFlashAttribute("error",
                        "Invalid username, password, or role combination");
                return "redirect:/login";
            }

        } catch (Exception e) {
            // Log the error (add proper logging)
            System.err.println("Login error: " + e.getMessage());
            redirectAttributes.addFlashAttribute("error",
                    "An error occurred during login. Please try again.");
            return "redirect:/login";
        }
    }

    // Dashboard mappings for different roles
    @GetMapping("/admin-dashboard")
    public String adminDashboard(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        if (!isValidSession(session, "admin")) {
            redirectAttributes.addFlashAttribute("error", "Please login to access admin dashboard");
            return "redirect:/login";
        }

        User user = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", user);
        model.addAttribute("dashboardStats", userService.getAdminDashboardStats());

        // Additional user info for admin dashboard
        model.addAttribute("totalUsers", userService.getTotalUsers());
        model.addAttribute("activeUsers", userService.getActiveUsers());

        return "admin-dashboard";
    }

    @GetMapping("/pharmacist-dashboard")
    public String pharmacistDashboard(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        if (!isValidSession(session, "pharmacist")) {
            redirectAttributes.addFlashAttribute("error", "Please login to access pharmacist dashboard");
            return "redirect:/login";
        }

        User user = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", user);
        model.addAttribute("prescriptions", userService.getPendingPrescriptions());

        // Pharmacist-specific data
        model.addAttribute("userFirstName", user.getFirstName());
        model.addAttribute("userLastName", user.getLastName());

        return "pharmacist-dashboard";
    }

    @GetMapping("/inventory-dashboard")
    public String inventoryDashboard(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        if (!isValidSession(session, "inventory")) {
            redirectAttributes.addFlashAttribute("error", "Please login to access inventory dashboard");
            return "redirect:/login";
        }

        User user = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", user);
        model.addAttribute("lowStockItems", userService.getLowStockItems());

        // Inventory-specific data
        model.addAttribute("userFirstName", user.getFirstName());
        model.addAttribute("userLastName", user.getLastName());

        return "inventory-dashboard";
    }

    @GetMapping("/cashier-dashboard")
    public String cashierDashboard(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        if (!isValidSession(session, "cashier")) {
            redirectAttributes.addFlashAttribute("error", "Please login to access cashier dashboard");
            return "redirect:/login";
        }

        User user = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", user);
        model.addAttribute("todaySales", userService.getTodaySales());

        // Cashier-specific data
        model.addAttribute("userFirstName", user.getFirstName());
        model.addAttribute("userLastName", user.getLastName());

        return "cashier-dashboard";
    }

    // Logout functionality
    @GetMapping("/logout")
    public String logout(HttpSession session, HttpServletResponse response,
                         RedirectAttributes redirectAttributes) {
        try {
            // Get user info for logout message
            User user = (User) session.getAttribute("loggedInUser");
            String userName = user != null ? user.getFirstName() : "User";

            // Clear session
            session.invalidate();

            // Clear remember me cookies
            Cookie userCookie = new Cookie("rememberedUser", "");
            userCookie.setMaxAge(0);
            userCookie.setPath("/");
            response.addCookie(userCookie);

            Cookie roleCookie = new Cookie("rememberedRole", "");
            roleCookie.setMaxAge(0);
            roleCookie.setPath("/");
            response.addCookie(roleCookie);

            redirectAttributes.addFlashAttribute("success",
                    "Goodbye " + userName + "! You have been successfully logged out");

        } catch (Exception e) {
            System.err.println("Logout error: " + e.getMessage());
            redirectAttributes.addFlashAttribute("success", "You have been successfully logged out");
        }

        return "redirect:/login";
    }

    // Forgot password page
    @GetMapping("/forgot-password")
    public String showForgotPasswordPage() {
        return "forgot-password";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(
            @RequestParam("username") String username,
            RedirectAttributes redirectAttributes) {

        try {
            boolean emailSent = userService.sendPasswordResetEmail(username);

            if (emailSent) {
                redirectAttributes.addFlashAttribute("success",
                        "Password reset instructions have been sent to your email");
            } else {
                redirectAttributes.addFlashAttribute("error",
                        "Username not found in our system");
            }

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error",
                    "An error occurred. Please try again later");
        }

        return "redirect:/forgot-password";
    }

    // Session check for AJAX requests
    @GetMapping("/check-session")
    @ResponseBody
    public Map<String, Object> checkSession(HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        if (session.getAttribute("loggedInUser") != null) {
            User user = (User) session.getAttribute("loggedInUser");
            response.put("valid", true);
            response.put("role", user.getRole());
            response.put("username", user.getUsername());
            response.put("fullName", user.getFullName());
            response.put("email", user.getEmail());
            response.put("firstName", user.getFirstName());
            response.put("lastName", user.getLastName());
        } else {
            response.put("valid", false);
        }

        return response;
    }

    // Access denied page
    @GetMapping("/access-denied")
    public String accessDenied() {
        return "access-denied";
    }

    // Profile page
    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        if (session.getAttribute("loggedInUser") == null) {
            redirectAttributes.addFlashAttribute("error", "Please login to view your profile");
            return "redirect:/login";
        }

        User user = (User) session.getAttribute("loggedInUser");
        model.addAttribute("user", user);

        // Add individual user attributes for easy access in JSP
        model.addAttribute("firstName", user.getFirstName());
        model.addAttribute("lastName", user.getLastName());
        model.addAttribute("email", user.getEmail());
        model.addAttribute("phone", user.getPhone());
        model.addAttribute("address", user.getAddress());
        model.addAttribute("age", user.getAge());
        model.addAttribute("gender", user.getGender());
        model.addAttribute("role", user.getRole());
        model.addAttribute("createdAt", user.getCreatedAt());
        model.addAttribute("lastLogin", user.getLastLogin());

        return "profile";
    }

    // Helper methods
    private boolean isValidSession(HttpSession session, String requiredRole) {
        Object userObj = session.getAttribute("loggedInUser");
        Object roleObj = session.getAttribute("userRole");

        if (userObj == null || roleObj == null) {
            return false;
        }

        String userRole = (String) roleObj;
        return requiredRole.equalsIgnoreCase(userRole);
    }

    private String getRoleDashboard(String role) {
        if (role == null) return "login";

        switch (role.toLowerCase()) {
            case "admin":
                return "admin-dashboard";
            case "pharmacist":
                return "pharmacist-dashboard";
            case "inventory":
                return "inventory-dashboard";
            case "cashier":
                return "cashier-dashboard";
            default:
                return "login";
        }
    }

    // Handle remember me cookies on login page load
    @ModelAttribute
    public void addRememberedUser(HttpServletRequest request, Model model) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("rememberedUser".equals(cookie.getName())) {
                    model.addAttribute("rememberedUser", cookie.getValue());
                } else if ("rememberedRole".equals(cookie.getName())) {
                    model.addAttribute("rememberedRole", cookie.getValue());
                }
            }
        }
    }
}
