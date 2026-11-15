<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PharmaCare System - Secure Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            /* Modern Color Palette */
            --primary-50: #f0f9ff;
            --primary-100: #e0f2fe;
            --primary-500: #0ea5e9;
            --primary-600: #0284c7;
            --primary-700: #0369a1;
            --primary-800: #075985;

            --secondary-50: #f0fdf4;
            --secondary-500: #22c55e;
            --secondary-600: #16a34a;
            --secondary-700: #15803d;

            --neutral-50: #f8fafc;
            --neutral-100: #f1f5f9;
            --neutral-200: #e2e8f0;
            --neutral-300: #cbd5e0;
            --neutral-400: #94a3b8;
            --neutral-500: #64748b;
            --neutral-600: #475569;
            --neutral-700: #334155;
            --neutral-800: #1e293b;
            --neutral-900: #0f172a;

            --error-50: #fef2f2;
            --error-500: #ef4444;
            --error-600: #dc2626;

            --warning-50: #fffbeb;
            --warning-500: #f59e0b;

            --success-50: #f0fdf4;
            --success-500: #22c55e;

            /* Shadows */
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
            --shadow-2xl: 0 25px 50px -12px rgb(0 0 0 / 0.25);

            /* Transitions */
            --transition-fast: 150ms ease;
            --transition-smooth: 300ms ease;
            --transition-slow: 500ms ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, var(--primary-600) 0%, var(--primary-800) 50%, var(--neutral-900) 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1.5rem;
            position: relative;
            overflow: hidden;
        }

        /* Animated background elements */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image:
                radial-gradient(circle at 20% 50%, rgba(14, 165, 233, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(34, 197, 94, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 40% 80%, rgba(147, 51, 234, 0.15) 0%, transparent 50%);
            animation: backgroundMove 20s ease-in-out infinite;
        }

        @keyframes backgroundMove {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            33% { transform: translate(30px, -30px) rotate(120deg); }
            66% { transform: translate(-20px, 20px) rotate(240deg); }
        }

        .login-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 24px;
            box-shadow: var(--shadow-2xl);
            overflow: hidden;
            width: 100%;
            max-width: 1100px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            min-height: 700px;
            position: relative;
            z-index: 1;
            animation: slideUp 0.8s cubic-bezier(0.4, 0, 0.2, 1);
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(60px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        /* Left Panel - Brand Section */
        .brand-panel {
            background: linear-gradient(135deg, var(--primary-600) 0%, var(--primary-700) 50%, var(--primary-800) 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 4rem 3rem;
            color: white;
            position: relative;
            overflow: hidden;
        }

        .brand-panel::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="1"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
            animation: gridMove 30s linear infinite;
            opacity: 0.3;
        }

        @keyframes gridMove {
            0% { transform: translate(0, 0); }
            100% { transform: translate(10px, 10px); }
        }

        .brand-logo {
            width: 80px;
            height: 80px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            margin-bottom: 2rem;
            z-index: 1;
            animation: logoFloat 6s ease-in-out infinite;
        }

        @keyframes logoFloat {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .brand-content {
            text-align: center;
            z-index: 1;
        }

        .brand-title {
            font-size: 2.75rem;
            font-weight: 800;
            margin-bottom: 1rem;
            background: linear-gradient(45deg, #ffffff, #e0f2fe);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .brand-subtitle {
            font-size: 1.25rem;
            opacity: 0.9;
            margin-bottom: 1rem;
            font-weight: 500;
        }

        .brand-description {
            font-size: 1rem;
            opacity: 0.8;
            line-height: 1.6;
            font-weight: 400;
        }

        .features-list {
            display: flex;
            gap: 2rem;
            margin-top: 2rem;
            z-index: 1;
        }

        .feature-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.875rem;
            opacity: 0.9;
        }

        .feature-icon {
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
        }

        /* Right Panel - Login Form */
        .login-panel {
            padding: 4rem 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: var(--neutral-50);
        }

        .login-header {
            margin-bottom: 2.5rem;
            text-align: center;
        }

        .login-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--neutral-800);
            margin-bottom: 0.5rem;
        }

        .login-subtitle {
            color: var(--neutral-500);
            font-size: 1rem;
            font-weight: 400;
        }

        /* Alert Messages */
        .alert {
            padding: 1rem 1.25rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            display: none;
            align-items: center;
            gap: 0.75rem;
            font-weight: 500;
            font-size: 0.875rem;
            animation: alertSlide 0.3s ease;
        }

        @keyframes alertSlide {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert.show {
            display: flex;
        }

        .alert-error {
            background: var(--error-50);
            color: var(--error-600);
            border: 1px solid var(--error-500);
        }

        .alert-success {
            background: var(--success-50);
            color: var(--secondary-700);
            border: 1px solid var(--secondary-500);
        }

        /* Role Selection */
        .role-section {
            margin-bottom: 2rem;
        }

        .section-label {
            font-weight: 600;
            color: var(--neutral-700);
            margin-bottom: 1rem;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .role-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 0.75rem;
        }

        .role-option {
            padding: 1rem;
            border: 2px solid var(--neutral-200);
            border-radius: 12px;
            background: white;
            cursor: pointer;
            transition: var(--transition-smooth);
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 500;
            color: var(--neutral-600);
            position: relative;
            overflow: hidden;
        }

        .role-option::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(14, 165, 233, 0.1), transparent);
            transition: left 0.5s ease;
        }

        .role-option:hover::before {
            left: 100%;
        }

        .role-option:hover {
            border-color: var(--primary-300);
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .role-option.active {
            border-color: var(--primary-500);
            background: var(--primary-50);
            color: var(--primary-700);
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .role-icon {
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.125rem;
        }

        .role-name {
            font-size: 0.875rem;
            font-weight: 500;
        }

        /* Form Fields */
        .form-group {
            margin-bottom: 1.5rem;
        }

        .field-label {
            display: block;
            font-weight: 600;
            color: var(--neutral-700);
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
        }

        .input-container {
            position: relative;
        }

        .input-field {
            width: 100%;
            padding: 1rem 1rem 1rem 3rem;
            border: 2px solid var(--neutral-200);
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 400;
            background: white;
            transition: var(--transition-smooth);
            color: var(--neutral-800);
        }

        .input-field:focus {
            outline: none;
            border-color: var(--primary-500);
            box-shadow: 0 0 0 4px rgba(14, 165, 233, 0.1);
            background: var(--primary-50);
        }

        .input-field::placeholder {
            color: var(--neutral-400);
            font-weight: 400;
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--neutral-400);
            font-size: 1.125rem;
            transition: var(--transition-fast);
        }

        .input-field:focus + .input-icon {
            color: var(--primary-500);
        }

        .password-toggle {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: var(--neutral-400);
            font-size: 1.125rem;
            transition: var(--transition-fast);
            padding: 0.25rem;
        }

        .password-toggle:hover {
            color: var(--primary-500);
        }

        /* Form Options */
        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .checkbox-container {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .checkbox {
            width: 18px;
            height: 18px;
            accent-color: var(--primary-500);
            border-radius: 4px;
        }

        .checkbox-label {
            font-size: 0.875rem;
            color: var(--neutral-600);
            font-weight: 500;
        }

        .forgot-link {
            color: var(--primary-600);
            text-decoration: none;
            font-size: 0.875rem;
            font-weight: 500;
            transition: var(--transition-fast);
        }

        .forgot-link:hover {
            color: var(--primary-700);
            text-decoration: underline;
        }

        /* Login Button */
        .login-button {
            width: 100%;
            padding: 1rem 2rem;
            background: linear-gradient(135deg, var(--primary-500) 0%, var(--primary-600) 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition-smooth);
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            box-shadow: var(--shadow-md);
        }

        .login-button:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-xl);
            background: linear-gradient(135deg, var(--primary-600) 0%, var(--primary-700) 100%);
        }

        .login-button:active {
            transform: translateY(0);
        }

        .login-button.loading {
            pointer-events: none;
        }

        .button-content {
            transition: opacity var(--transition-fast);
        }

        .button-spinner {
            position: absolute;
            opacity: 0;
            transition: opacity var(--transition-fast);
        }

        .login-button.loading .button-content {
            opacity: 0;
        }

        .login-button.loading .button-spinner {
            opacity: 1;
        }

        .spinner {
            width: 20px;
            height: 20px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Test Credentials */
        .test-section {
            margin-top: 2rem;
            padding: 1.5rem;
            background: var(--neutral-100);
            border: 1px solid var(--neutral-200);
            border-radius: 12px;
        }

        .test-header {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--primary-600);
            font-weight: 600;
            margin-bottom: 1rem;
            font-size: 0.875rem;
        }

        .credential-grid {
            display: grid;
            gap: 0.5rem;
        }

        .credential-item {
            padding: 0.75rem;
            background: white;
            border: 1px solid var(--neutral-200);
            border-radius: 8px;
            cursor: pointer;
            transition: var(--transition-fast);
            font-size: 0.75rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .credential-item:hover {
            background: var(--primary-50);
            border-color: var(--primary-200);
            transform: translateX(4px);
        }

        .credential-role {
            font-weight: 600;
            color: var(--neutral-700);
        }

        .credential-details {
            color: var(--neutral-500);
            font-family: 'Courier New', monospace;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .login-container {
                grid-template-columns: 1fr;
                max-width: 500px;
            }

            .brand-panel {
                padding: 3rem 2rem;
            }

            .brand-title {
                font-size: 2.25rem;
            }

            .features-list {
                gap: 1rem;
            }

            .login-panel {
                padding: 3rem 2rem;
            }
        }

        @media (max-width: 640px) {
            body {
                padding: 1rem;
            }

            .login-container {
                min-height: auto;
            }

            .brand-panel {
                padding: 2rem 1.5rem;
            }

            .brand-title {
                font-size: 2rem;
            }

            .login-panel {
                padding: 2rem 1.5rem;
            }

            .role-grid {
                grid-template-columns: 1fr;
            }

            .features-list {
                flex-direction: column;
                gap: 1rem;
            }

            .test-section {
                padding: 1rem;
            }
        }

        /* Accessibility */
        @media (prefers-reduced-motion: reduce) {
            * {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
        }

        /* Focus visibility */
        .role-option:focus,
        .input-field:focus,
        .login-button:focus,
        .credential-item:focus {
            outline: 2px solid var(--primary-500);
            outline-offset: 2px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <!-- Brand Panel -->
        <div class="brand-panel">
            <div class="brand-logo">
                <i class="fas fa-pills"></i>
            </div>
            <div class="brand-content">
                <h1 class="brand-title">PharmaCare</h1>
                <p class="brand-subtitle">Healthcare Management System</p>
                <p class="brand-description">
                    Secure, efficient, and comprehensive pharmacy management solution
                    trusted by healthcare professionals worldwide.
                </p>
            </div>
            <div class="features-list">
                <div class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <span>Secure</span>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <span>Fast</span>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <span>Reliable</span>
                </div>
            </div>
        </div>

        <!-- Login Panel -->
        <div class="login-panel">
            <div class="login-header">
                <h2 class="login-title">Welcome Back</h2>
                <p class="login-subtitle">Please sign in to your account</p>
            </div>

            <!-- Alert Messages -->
            <div class="alert alert-error" id="errorAlert">
                <i class="fas fa-exclamation-triangle"></i>
                <span id="errorMessage">
                    <c:if test="${not empty error}">${error}</c:if>
                </span>
            </div>

            <div class="alert alert-success" id="successAlert">
                <i class="fas fa-check-circle"></i>
                <span id="successMessage">
                    <c:if test="${not empty success}">${success}</c:if>
                </span>
            </div>

            <!-- Login Form -->
            <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm" novalidate>
                <!-- Role Selection -->
                <div class="role-section">
                    <label class="section-label">Select Your Role</label>
                    <div class="role-grid">
                        <div class="role-option" data-role="admin" tabindex="0">
                            <div class="role-icon">
                                <i class="fas fa-user-shield"></i>
                            </div>
                            <span class="role-name">Administrator</span>
                        </div>
                        <div class="role-option" data-role="pharmacist" tabindex="0">
                            <div class="role-icon">
                                <i class="fas fa-user-md"></i>
                            </div>
                            <span class="role-name">Pharmacist</span>
                        </div>
                        <div class="role-option" data-role="inventory" tabindex="0">
                            <div class="role-icon">
                                <i class="fas fa-boxes"></i>
                            </div>
                            <span class="role-name">Inventory Manager</span>
                        </div>
                        <div class="role-option" data-role="cashier" tabindex="0">
                            <div class="role-icon">
                                <i class="fas fa-cash-register"></i>
                            </div>
                            <span class="role-name">Cashier</span>
                        </div>
                    </div>
                    <input type="hidden" name="role" id="selectedRole" required>
                </div>

                <!-- Username Field -->
                <div class="form-group">
                    <label for="username" class="field-label">Username</label>
                    <div class="input-container">
                        <input
                            type="text"
                            id="username"
                            name="username"
                            class="input-field"
                            placeholder="Enter your username"
                            value="${param.username}"
                            required
                            autocomplete="username"
                        >
                        <i class="fas fa-user input-icon"></i>
                    </div>
                </div>

                <!-- Password Field -->
                <div class="form-group">
                    <label for="password" class="field-label">Password</label>
                    <div class="input-container">
                        <input
                            type="password"
                            id="password"
                            name="password"
                            class="input-field"
                            placeholder="Enter your password"
                            required
                            autocomplete="current-password"
                        >
                        <i class="fas fa-lock input-icon"></i>
                        <i class="fas fa-eye password-toggle" id="togglePassword"></i>
                    </div>
                </div>

                <!-- Form Options -->
                <div class="form-options">
                    <div class="checkbox-container">
                        <input type="checkbox" id="rememberMe" name="rememberMe" class="checkbox">
                        <label for="rememberMe" class="checkbox-label">Remember me</label>
                    </div>
                    <a href="${pageContext.request.contextPath}/forgot-password" class="forgot-link">
                        Forgot password?
                    </a>
                </div>

                <!-- Login Button -->
                <button type="submit" class="login-button" id="loginButton">
                    <span class="button-content">
                        <i class="fas fa-sign-in-alt"></i>
                        Sign In
                    </span>
                    <div class="button-spinner">
                        <div class="spinner"></div>
                    </div>
                </button>
            </form>

            <!-- Test Credentials -->
            <div class="test-section">
                <div class="test-header">
                    <i class="fas fa-info-circle"></i>
                    Demo Credentials
                </div>
                <div class="credential-grid">
                    <div class="credential-item" onclick="fillCredentials('admin', 'admin123', 'admin')" tabindex="0">
                        <span class="credential-role">Administrator</span>
                        <span class="credential-details">admin / admin123</span>
                    </div>
                    <div class="credential-item" onclick="fillCredentials('pharmacist1', 'pharm123', 'pharmacist')" tabindex="0">
                        <span class="credential-role">Pharmacist</span>
                        <span class="credential-details">pharmacist1 / pharm123</span>
                    </div>
                    <div class="credential-item" onclick="fillCredentials('inventory1', 'inv123', 'inventory')" tabindex="0">
                        <span class="credential-role">Inventory</span>
                        <span class="credential-details">inventory1 / inv123</span>
                    </div>
                    <div class="credential-item" onclick="fillCredentials('cashier1', 'cash123', 'cashier')" tabindex="0">
                        <span class="credential-role">Cashier</span>
                        <span class="credential-details">cashier1 / cash123</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Initialize the form
        document.addEventListener('DOMContentLoaded', function() {
            initializeRoleSelection();
            initializePasswordToggle();
            initializeFormSubmission();
            initializeAlerts();
            initializeAccessibility();
        });

        // Role selection functionality
        function initializeRoleSelection() {
            const roleOptions = document.querySelectorAll('.role-option');
            const selectedRoleInput = document.getElementById('selectedRole');

            roleOptions.forEach(option => {
                option.addEventListener('click', function() {
                    selectRole(this);
                });

                option.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter' || e.key === ' ') {
                        e.preventDefault();
                        selectRole(this);
                    }
                });
            });

            function selectRole(option) {
                roleOptions.forEach(opt => opt.classList.remove('active'));
                option.classList.add('active');
                selectedRoleInput.value = option.dataset.role;
            }

            // Pre-select role if remembered
            <c:if test="${not empty rememberedRole}">
                const rememberedOption = document.querySelector(`[data-role="${rememberedRole}"]`);
                if (rememberedOption) {
                    selectRole(rememberedOption);
                }
            </c:if>
        }

        // Password toggle functionality
        function initializePasswordToggle() {
            const toggleButton = document.getElementById('togglePassword');
            const passwordField = document.getElementById('password');

            toggleButton.addEventListener('click', function() {
                const isPassword = passwordField.type === 'password';
                passwordField.type = isPassword ? 'text' : 'password';
                this.classList.toggle('fa-eye', !isPassword);
                this.classList.toggle('fa-eye-slash', isPassword);
            });
        }

        // Form submission with validation and loading state
        function initializeFormSubmission() {
            const form = document.getElementById('loginForm');
            const submitButton = document.getElementById('loginButton');

            form.addEventListener('submit', function(e) {
                const selectedRole = document.getElementById('selectedRole').value;

                if (!selectedRole) {
                    e.preventDefault();
                    showAlert('error', 'Please select your role before signing in.');
                    return;
                }

                // Show loading state
                submitButton.classList.add('loading');
                submitButton.disabled = true;

                // Reset loading state after timeout (in case of no redirect)
                setTimeout(() => {
                    submitButton.classList.remove('loading');
                    submitButton.disabled = false;
                }, 10000);
            });
        }

        // Alert system
        function initializeAlerts() {
            <c:if test="${not empty error}">
                showAlert('error', '${error}');
            </c:if>

            <c:if test="${not empty success}">
                showAlert('success', '${success}');
            </c:if>
        }

        function showAlert(type, message) {
            const alertElement = document.getElementById(type + 'Alert');
            const messageElement = document.getElementById(type + 'Message');

            messageElement.textContent = message;
            alertElement.classList.add('show');

            setTimeout(() => {
                alertElement.classList.remove('show');
            }, 5000);
        }

        // Fill test credentials
        function fillCredentials(username, password, role) {
            document.getElementById('username').value = username;
            document.getElementById('password').value = password;

            // Select the appropriate role
            const roleOption = document.querySelector(`[data-role="${role}"]`);
            if (roleOption) {
                document.querySelectorAll('.role-option').forEach(opt => opt.classList.remove('active'));
                roleOption.classList.add('active');
                document.getElementById('selectedRole').value = role;
            }

            // Focus on the login button
            document.getElementById('loginButton').focus();
        }

        // Enhanced accessibility
        function initializeAccessibility() {
            // Add keyboard navigation for credential items
            document.querySelectorAll('.credential-item').forEach(item => {
                item.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter' || e.key === ' ') {
                        e.preventDefault();
                        this.click();
                    }
                });
            });

            // Enhanced focus management
            const form = document.getElementById('loginForm');
            form.addEventListener('keydown', function(e) {
                if (e.key === 'Tab') {
                    // Custom tab handling if needed
                }
            });
        }

        // Auto-fill remembered credentials
        <c:if test="${not empty rememberedUser}">
            document.getElementById('username').value = '${rememberedUser}';
        </c:if>

        // Form field enhancements
        document.querySelectorAll('.input-field').forEach(field => {
            field.addEventListener('focus', function() {
                this.closest('.input-container').style.transform = 'translateY(-1px)';
            });

            field.addEventListener('blur', function() {
                this.closest('.input-container').style.transform = 'translateY(0)';
            });
        });
    </script>
</body>
</html>
