<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update User – PharmaCare Admin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-500: #6366f1;
            --primary-600: #5b21b6;
            --primary-700: #4c1d95;
            --primary-50: #f0f9ff;
            --primary-100: #e0e7ff;

            --secondary-500: #10b981;
            --secondary-600: #059669;
            --secondary-700: #047857;
            --secondary-50: #ecfdf5;
            --secondary-100: #d1fae5;

            --gray-50: #f9fafb;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --gray-300: #d1d5db;
            --gray-400: #9ca3af;
            --gray-500: #6b7280;
            --gray-600: #4b5563;
            --gray-700: #374151;
            --gray-800: #1f2937;
            --gray-900: #111827;

            --success-50: #f0fdf4;
            --success-500: #22c55e;
            --success-600: #16a34a;
            --success-100: #dcfce7;

            --warning-50: #fffbeb;
            --warning-500: #f59e0b;
            --warning-600: #d97706;
            --warning-100: #fef3c7;

            --danger-50: #fef2f2;
            --danger-500: #ef4444;
            --danger-600: #dc2626;
            --danger-100: #fee2e2;

            --info-50: #f0f9ff;
            --info-500: #06b6d4;
            --info-600: #0891b2;
            --info-100: #cffafe;

            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1);
            --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1);
            --shadow-2xl: 0 25px 50px -12px rgb(0 0 0 / 0.25);

            --radius-sm: 6px;
            --radius-md: 8px;
            --radius-lg: 12px;
            --radius-xl: 16px;
            --radius-2xl: 20px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background: var(--gray-50);
            color: var(--gray-900);
            line-height: 1.6;
        }

        /* Navigation */
        .navbar {
            background: white;
            border-bottom: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            position: sticky;
            top: 0;
            z-index: 50;
        }

        .navbar-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            text-decoration: none;
            color: var(--gray-900);
            font-weight: 700;
            font-size: 1.25rem;
        }

        .brand-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--primary-500), var(--primary-600));
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.125rem;
        }

        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--gray-500);
            font-size: 0.875rem;
        }

        .breadcrumb a {
            color: var(--primary-600);
            text-decoration: none;
            font-weight: 500;
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.5rem;
            border-radius: var(--radius-lg);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .user-menu:hover {
            background: var(--gray-50);
        }

        .user-avatar {
            width: 36px;
            height: 36px;
            background: linear-gradient(135deg, var(--secondary-500), var(--secondary-600));
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 0.875rem;
        }

        /* Main Content */
        .main-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Page Header */
        .page-header {
            margin-bottom: 2rem;
        }

        .header-content {
            background: white;
            border-radius: var(--radius-2xl);
            padding: 2rem;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--gray-200);
            position: relative;
            overflow: hidden;
        }

        .header-content::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-500), var(--secondary-500));
        }

        .header-info {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            margin-bottom: 1rem;
        }

        .header-avatar {
            width: 80px;
            height: 80px;
            border-radius: var(--radius-xl);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 1.5rem;
            flex-shrink: 0;
        }

        .header-details h1 {
            font-size: 2rem;
            font-weight: 800;
            color: var(--gray-900);
            margin-bottom: 0.5rem;
        }

        .header-meta {
            display: flex;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.875rem;
            color: var(--gray-600);
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.375rem;
            padding: 0.375rem 0.875rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.025em;
        }

        .status-active {
            background: var(--success-100);
            color: var(--success-700);
            border: 1px solid var(--success-200);
        }

        .status-inactive {
            background: var(--danger-100);
            color: var(--danger-700);
            border: 1px solid var(--danger-200);
        }

        /* Form Container */
        .form-container {
            background: white;
            border-radius: var(--radius-2xl);
            padding: 3rem;
            box-shadow: var(--shadow-xl);
            border: 1px solid var(--gray-200);
            position: relative;
            overflow: hidden;
        }

        .form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--warning-500), var(--info-500));
        }

        /* Form Sections */
        .form-section {
            margin-bottom: 3rem;
        }

        .form-section:last-child {
            margin-bottom: 0;
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--gray-900);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--gray-100);
        }

        .section-icon {
            width: 32px;
            height: 32px;
            background: linear-gradient(135deg, var(--warning-100), var(--warning-200));
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--warning-600);
            font-size: 0.875rem;
        }

        /* Form Grid */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-label {
            font-weight: 600;
            color: var(--gray-700);
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-label.required::after {
            content: '*';
            color: var(--danger-500);
            font-weight: 700;
        }

        .label-icon {
            color: var(--gray-400);
            font-size: 0.75rem;
        }

        /* Form Controls */
        .form-control, .form-select {
            padding: 1rem 1.25rem;
            border: 2px solid var(--gray-200);
            border-radius: var(--radius-lg);
            background: var(--gray-50);
            color: var(--gray-900);
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            position: relative;
        }

        .form-control:focus, .form-select:focus {
            outline: none;
            border-color: var(--primary-500);
            background: white;
            box-shadow: 0 0 0 3px rgb(99 102 241 / 0.1);
            transform: translateY(-1px);
        }

        .form-control:valid:not(:placeholder-shown) {
            border-color: var(--success-500);
            background: var(--success-50);
        }

        .form-select {
            cursor: pointer;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
            background-position: right 0.75rem center;
            background-repeat: no-repeat;
            background-size: 1.5em 1.5em;
            padding-right: 3rem;
        }

        /* Input Groups */
        .input-group {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray-400);
            font-size: 1.125rem;
            z-index: 1;
        }

        .input-group .form-control {
            padding-left: 3rem;
        }

        /* Role Selection */
        .role-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .role-card {
            padding: 1.5rem;
            border: 2px solid var(--gray-200);
            border-radius: var(--radius-lg);
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            background: var(--gray-50);
        }

        .role-card:hover {
            border-color: var(--primary-300);
            background: var(--primary-50);
            transform: translateY(-2px);
        }

        .role-card.selected {
            border-color: var(--primary-500);
            background: var(--primary-50);
            box-shadow: 0 0 0 3px rgb(99 102 241 / 0.1);
        }

        .role-icon {
            font-size: 2rem;
            margin-bottom: 1rem;
        }

        .role-icon.admin { color: var(--danger-500); }
        .role-icon.pharmacist { color: var(--info-500); }
        .role-icon.inventory { color: var(--warning-500); }
        .role-icon.cashier { color: var(--secondary-500); }

        .role-title {
            font-weight: 600;
            color: var(--gray-900);
            margin-bottom: 0.5rem;
        }

        .role-description {
            font-size: 0.875rem;
            color: var(--gray-600);
        }

        /* Toggle Switch */
        .toggle-container {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1.5rem;
            background: var(--gray-50);
            border-radius: var(--radius-lg);
            border: 2px solid var(--gray-200);
            margin-top: 0.5rem;
        }

        .toggle-switch {
            position: relative;
            width: 60px;
            height: 32px;
            background: var(--gray-300);
            border-radius: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .toggle-switch.active {
            background: var(--success-500);
        }

        .toggle-slider {
            position: absolute;
            top: 4px;
            left: 4px;
            width: 24px;
            height: 24px;
            background: white;
            border-radius: 50%;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-sm);
        }

        .toggle-switch.active .toggle-slider {
            transform: translateX(28px);
        }

        .toggle-info {
            flex: 1;
        }

        .toggle-title {
            font-weight: 600;
            color: var(--gray-900);
            margin-bottom: 0.25rem;
        }

        .toggle-description {
            font-size: 0.875rem;
            color: var(--gray-600);
        }

        /* Alert Messages */
        .alert {
            padding: 1rem 1.5rem;
            border-radius: var(--radius-lg);
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 500;
            position: relative;
            overflow: hidden;
        }

        .alert::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
        }

        .alert.success {
            background: var(--success-50);
            border: 1px solid var(--success-200);
            color: var(--success-800);
        }

        .alert.success::before {
            background: var(--success-500);
        }

        .alert.error {
            background: var(--danger-50);
            border: 1px solid var(--danger-200);
            color: var(--danger-800);
        }

        .alert.error::before {
            background: var(--danger-500);
        }

        /* Form Actions */
        .form-actions {
            margin-top: 3rem;
            padding-top: 2rem;
            border-top: 2px solid var(--gray-100);
            display: flex;
            gap: 1rem;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: var(--radius-lg);
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            text-decoration: none;
            min-width: 140px;
            justify-content: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--warning-500), var(--warning-600));
            color: white;
            box-shadow: var(--shadow-lg);
        }

        .btn-primary:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: var(--shadow-xl);
        }

        .btn-primary:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        .btn-secondary {
            background: white;
            color: var(--gray-700);
            border: 2px solid var(--gray-300);
        }

        .btn-secondary:hover {
            background: var(--gray-50);
            border-color: var(--gray-400);
            text-decoration: none;
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--danger-500), var(--danger-600));
            color: white;
            box-shadow: var(--shadow-lg);
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-xl);
        }

        /* Loading States */
        .loading-spinner {
            display: none;
            width: 16px;
            height: 16px;
            border: 2px solid transparent;
            border-top: 2px solid currentColor;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-container {
                padding: 1rem;
            }

            .form-container {
                padding: 2rem 1.5rem;
            }

            .header-content {
                padding: 1.5rem;
            }

            .header-info {
                flex-direction: column;
                align-items: flex-start;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-actions {
                flex-direction: column;
            }

            .role-cards {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 480px) {
            .navbar-container {
                padding: 1rem;
            }

            .form-container {
                padding: 1.5rem 1rem;
            }

            .header-avatar {
                width: 60px;
                height: 60px;
                font-size: 1.25rem;
            }

            .header-details h1 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>

<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="navbar-container">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="navbar-brand">
                <div class="brand-icon">
                    <i class="fas fa-shield-alt"></i>
                </div>
                PharmaCare Admin
            </a>

            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                <i class="fas fa-chevron-right"></i>
                <a href="${pageContext.request.contextPath}/admin/users">Users</a>
                <i class="fas fa-chevron-right"></i>
                <span>Edit User</span>
            </div>

            <div class="user-menu">
                <div class="user-avatar">AD</div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main-container">
        <!-- Page Header -->
        <div class="page-header">
            <div class="header-content">
                <div class="header-info">
                    <div class="header-avatar" style="background: linear-gradient(135deg, ${user.role == 'admin' ? 'var(--danger-500), var(--danger-600)' : (user.role == 'pharmacist' ? 'var(--info-500), var(--info-600)' : (user.role == 'inventory' ? 'var(--warning-500), var(--warning-600)' : 'var(--secondary-500), var(--secondary-600)'))})">
                        ${user.firstName.substring(0,1)}${user.lastName.substring(0,1)}
                    </div>
                    <div class="header-details">
                        <h1>Update User Profile</h1>
                        <div class="header-meta">
                            <div class="meta-item">
                                <i class="fas fa-user"></i>
                                <span>${user.firstName} ${user.lastName}</span>
                            </div>
                            <div class="meta-item">
                                <i class="fas fa-envelope"></i>
                                <span>${user.email}</span>
                            </div>
                            <span class="status-badge ${user.active ? 'status-active' : 'status-inactive'}">
                                <i class="fas fa-${user.active ? 'check' : 'times'}"></i>
                                ${user.active ? 'Active' : 'Inactive'}
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Alert Messages -->
        <c:if test="${not empty success}">
            <div class="alert success" id="successAlert">
                <i class="fas fa-check-circle"></i>
                <span>${success}</span>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert error" id="errorAlert">
                <i class="fas fa-exclamation-triangle"></i>
                <span>${error}</span>
            </div>
        </c:if>

        <!-- Form Container -->
        <div class="form-container">
            <form action="${pageContext.request.contextPath}/admin/update-user" method="POST" id="updateUserForm">
                <input type="hidden" name="id" value="${user.id}"/>

                <!-- Personal Information Section -->
                <div class="form-section">
                    <h2 class="section-title">
                        <div class="section-icon">
                            <i class="fas fa-user"></i>
                        </div>
                        Personal Information
                    </h2>

                    <div class="form-grid">
                        <div class="form-group">
                            <label for="firstName" class="form-label required">
                                <i class="fas fa-user label-icon"></i>
                                First Name
                            </label>
                            <div class="input-group">
                                <i class="fas fa-user input-icon"></i>
                                <input type="text" id="firstName" name="firstName" class="form-control"
                                       value="${user.firstName}" required maxlength="50">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="lastName" class="form-label required">
                                <i class="fas fa-user label-icon"></i>
                                Last Name
                            </label>
                            <div class="input-group">
                                <i class="fas fa-user input-icon"></i>
                                <input type="text" id="lastName" name="lastName" class="form-control"
                                       value="${user.lastName}" required maxlength="50">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="username" class="form-label required">
                                <i class="fas fa-at label-icon"></i>
                                Username
                            </label>
                            <div class="input-group">
                                <i class="fas fa-at input-icon"></i>
                                <input type="text" id="username" name="username" class="form-control"
                                       value="${user.username}" required minlength="3" maxlength="20">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="email" class="form-label required">
                                <i class="fas fa-envelope label-icon"></i>
                                Email Address
                            </label>
                            <div class="input-group">
                                <i class="fas fa-envelope input-icon"></i>
                                <input type="email" id="email" name="email" class="form-control"
                                       value="${user.email}" required>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Role Selection Section -->
                <div class="form-section">
                    <h2 class="section-title">
                        <div class="section-icon">
                            <i class="fas fa-users-cog"></i>
                        </div>
                        Role & Permissions
                    </h2>

                    <input type="hidden" id="roleHidden" name="role" value="${user.role}" required>

                    <div class="role-cards">
                        <div class="role-card ${user.role == 'admin' ? 'selected' : ''}" data-role="admin">
                            <div class="role-icon admin">
                                <i class="fas fa-crown"></i>
                            </div>
                            <div class="role-title">Administrator</div>
                            <div class="role-description">Full system access and control</div>
                        </div>

                        <div class="role-card ${user.role == 'pharmacist' ? 'selected' : ''}" data-role="pharmacist">
                            <div class="role-icon pharmacist">
                                <i class="fas fa-user-md"></i>
                            </div>
                            <div class="role-title">Pharmacist</div>
                            <div class="role-description">Prescription and medicine management</div>
                        </div>

                        <div class="role-card ${user.role == 'inventory' ? 'selected' : ''}" data-role="inventory">
                            <div class="role-icon inventory">
                                <i class="fas fa-boxes"></i>
                            </div>
                            <div class="role-title">Inventory Manager</div>
                            <div class="role-description">Stock and inventory control</div>
                        </div>

                        <div class="role-card ${user.role == 'cashier' ? 'selected' : ''}" data-role="cashier">
                            <div class="role-icon cashier">
                                <i class="fas fa-cash-register"></i>
                            </div>
                            <div class="role-title">Cashier</div>
                            <div class="role-description">Sales and payment processing</div>
                        </div>
                    </div>
                </div>

                <!-- Account Status Section -->
                <div class="form-section">
                    <h2 class="section-title">
                        <div class="section-icon">
                            <i class="fas fa-toggle-on"></i>
                        </div>
                        Account Status
                    </h2>

                    <div class="form-group">
                        <div class="toggle-container">
                            <div class="toggle-switch ${user.active ? 'active' : ''}" id="activeToggle">
                                <div class="toggle-slider"></div>
                            </div>
                            <div class="toggle-info">
                                <div class="toggle-title">Account Active Status</div>
                                <div class="toggle-description">Enable or disable this user's access to the system</div>
                            </div>
                        </div>
                        <input type="hidden" name="active" id="activeHidden" value="${user.active}">
                    </div>
                </div>

                <!-- Form Actions -->
                <div class="form-actions">
                    <div style="display: flex; gap: 1rem;">
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i>
                            Cancel
                        </a>
                        <button type="button" class="btn btn-danger" onclick="confirmDelete()">
                            <i class="fas fa-trash"></i>
                            Delete User
                        </button>
                    </div>

                    <button type="submit" class="btn btn-primary" id="submitBtn">
                        <span class="loading-spinner" id="loadingSpinner"></span>
                        <i class="fas fa-save" id="submitIcon"></i>
                        Save Changes
                    </button>
                </div>
            </form>
        </div>
    </main>

    <!-- Scripts -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('updateUserForm');
            const submitBtn = document.getElementById('submitBtn');
            const loadingSpinner = document.getElementById('loadingSpinner');
            const submitIcon = document.getElementById('submitIcon');
            const roleCards = document.querySelectorAll('.role-card');
            const roleHidden = document.getElementById('roleHidden');
            const activeToggle = document.getElementById('activeToggle');
            const activeHidden = document.getElementById('activeHidden');

            // Auto-hide alerts
            const successAlert = document.getElementById('successAlert');
            const errorAlert = document.getElementById('errorAlert');

            if (successAlert) {
                setTimeout(() => hideAlert(successAlert), 5000);
            }

            if (errorAlert) {
                setTimeout(() => hideAlert(errorAlert), 5000);
            }

            function hideAlert(alert) {
                alert.style.opacity = '0';
                alert.style.transform = 'translateY(-10px)';
                setTimeout(() => alert.remove(), 300);
            }

            // Role selection
            roleCards.forEach(card => {
                card.addEventListener('click', function() {
                    roleCards.forEach(c => c.classList.remove('selected'));
                    this.classList.add('selected');
                    roleHidden.value = this.dataset.role;
                });
            });

            // Toggle switch
            activeToggle.addEventListener('click', function() {
                this.classList.toggle('active');
                const isActive = this.classList.contains('active');
                activeHidden.value = isActive;
            });

            // Form validation
            const inputs = form.querySelectorAll('input[type="text"], input[type="email"]');
            inputs.forEach(input => {
                input.addEventListener('blur', validateField);
                input.addEventListener('input', validateField);
            });

            function validateField(e) {
                const field = e.target;
                const isValid = field.checkValidity();

                if (!isValid && field.value) {
                    field.style.borderColor = 'var(--danger-500)';
                    field.style.background = 'var(--danger-50)';
                } else if (isValid && field.value) {
                    field.style.borderColor = 'var(--success-500)';
                    field.style.background = 'var(--success-50)';
                } else {
                    field.style.borderColor = 'var(--gray-200)';
                    field.style.background = 'var(--gray-50)';
                }
            }

            // Form submission
            form.addEventListener('submit', function(e) {
                submitBtn.disabled = true;
                loadingSpinner.style.display = 'inline-block';
                submitIcon.style.display = 'none';
                submitBtn.innerHTML = '<span class="loading-spinner" style="display: inline-block;"></span> Saving Changes...';
            });

            // Username input filtering
            document.getElementById('username').addEventListener('input', function() {
                this.value = this.value.replace(/[^a-zA-Z0-9_]/g, '');
            });
        });

        function confirmDelete() {
            if (confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
                window.location.href = '${pageContext.request.contextPath}/admin/delete-user/${user.id}';
            }
        }
    </script>
</body>
</html>
