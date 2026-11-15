<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management – PharmaCare Admin</title>
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

        .navbar-nav {
            display: flex;
            align-items: center;
            gap: 2rem;
            list-style: none;
        }

        .nav-link {
            color: var(--gray-600);
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: var(--radius-md);
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .nav-link:hover, .nav-link.active {
            background: var(--primary-50);
            color: var(--primary-600);
        }

        .navbar-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
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

        .user-info {
            display: flex;
            flex-direction: column;
        }

        .user-name {
            font-weight: 600;
            font-size: 0.875rem;
            color: var(--gray-900);
        }

        .user-role {
            font-size: 0.75rem;
            color: var(--gray-500);
        }

        /* Main Content */
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Page Header */
        .page-header {
            background: white;
            border-radius: var(--radius-2xl);
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--gray-200);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1.5rem;
        }

        .header-info h1 {
            font-size: 2rem;
            font-weight: 800;
            color: var(--gray-900);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .header-info p {
            color: var(--gray-600);
            font-size: 1.125rem;
        }

        .header-stats {
            display: flex;
            gap: 2rem;
            align-items: center;
        }

        .stat-item {
            text-align: center;
        }

        .stat-number {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-600);
            margin-bottom: 0.25rem;
        }

        .stat-label {
            font-size: 0.875rem;
            color: var(--gray-500);
            font-weight: 500;
        }

        /* Actions Bar */
        .actions-bar {
            background: white;
            border-radius: var(--radius-xl);
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--gray-200);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .search-filters {
            display: flex;
            align-items: center;
            gap: 1rem;
            flex: 1;
        }

        .search-box {
            position: relative;
            flex: 1;
            max-width: 400px;
        }

        .search-input {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 2.75rem;
            border: 1px solid var(--gray-300);
            border-radius: var(--radius-lg);
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary-500);
            box-shadow: 0 0 0 3px rgb(99 102 241 / 0.1);
        }

        .search-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray-400);
            font-size: 1.125rem;
        }

        .filter-dropdown {
            padding: 0.75rem 1rem;
            border: 1px solid var(--gray-300);
            border-radius: var(--radius-lg);
            background: white;
            color: var(--gray-700);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            min-width: 120px;
        }

        .filter-dropdown:hover {
            border-color: var(--primary-300);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-500), var(--primary-600));
            color: white;
            padding: 0.875rem 1.5rem;
            border: none;
            border-radius: var(--radius-lg);
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            cursor: pointer;
            font-size: 0.875rem;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        /* Alert Messages */
        .alert {
            padding: 1rem 1.5rem;
            border-radius: var(--radius-lg);
            margin-bottom: 1.5rem;
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

        /* Data Table */
        .table-container {
            background: white;
            border-radius: var(--radius-2xl);
            overflow: hidden;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--gray-200);
        }

        .table-header {
            background: var(--gray-50);
            padding: 1.5rem 2rem;
            border-bottom: 1px solid var(--gray-200);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--gray-900);
        }

        .table-meta {
            font-size: 0.875rem;
            color: var(--gray-500);
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table thead {
            background: linear-gradient(135deg, var(--gray-700), var(--gray-800));
        }

        .data-table th {
            padding: 1.25rem 1.5rem;
            text-align: left;
            font-weight: 600;
            color: white;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            border-bottom: 2px solid var(--gray-600);
        }

        .data-table tbody tr {
            transition: all 0.3s ease;
            border-bottom: 1px solid var(--gray-100);
        }

        .data-table tbody tr:hover {
            background: var(--gray-50);
            transform: scale(1.005);
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
        }

        .data-table td {
            padding: 1.25rem 1.5rem;
            font-weight: 500;
            color: var(--gray-700);
            vertical-align: middle;
        }

        .user-cell {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-avatar-large {
            width: 48px;
            height: 48px;
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 1rem;
            flex-shrink: 0;
        }

        .user-details h4 {
            font-size: 1rem;
            font-weight: 600;
            color: var(--gray-900);
            margin-bottom: 0.25rem;
        }

        .user-id {
            font-size: 0.875rem;
            color: var(--gray-500);
            font-family: 'SF Mono', Monaco, monospace;
        }

        .username-badge {
            background: var(--gray-100);
            border: 1px solid var(--gray-200);
            padding: 0.375rem 0.75rem;
            border-radius: var(--radius-md);
            font-family: 'SF Mono', Monaco, monospace;
            font-size: 0.875rem;
            font-weight: 600;
            color: var(--gray-700);
        }

        .role-badge {
            padding: 0.375rem 0.875rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: capitalize;
            letter-spacing: 0.025em;
        }

        .role-admin {
            background: var(--danger-100);
            color: var(--danger-700);
            border: 1px solid var(--danger-200);
        }

        .role-pharmacist {
            background: var(--info-100);
            color: var(--info-700);
            border: 1px solid var(--info-200);
        }

        .role-cashier {
            background: var(--warning-100);
            color: var(--warning-700);
            border: 1px solid var(--warning-200);
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

        .actions-cell {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }

        .btn-icon {
            width: 36px;
            height: 36px;
            border: none;
            border-radius: var(--radius-md);
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 0.875rem;
        }

        .btn-edit {
            background: var(--warning-100);
            color: var(--warning-700);
            border: 1px solid var(--warning-200);
        }

        .btn-edit:hover {
            background: var(--warning-500);
            color: white;
            transform: translateY(-1px);
            box-shadow: var(--shadow-md);
        }

        .btn-delete {
            background: var(--danger-100);
            color: var(--danger-700);
            border: 1px solid var(--danger-200);
        }

        .btn-delete:hover {
            background: var(--danger-500);
            color: white;
            transform: translateY(-1px);
            box-shadow: var(--shadow-md);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--gray-500);
        }

        .empty-icon {
            width: 80px;
            height: 80px;
            background: var(--gray-100);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin: 0 auto 1.5rem;
            color: var(--gray-400);
        }

        .empty-state h3 {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--gray-700);
            margin-bottom: 0.5rem;
        }

        .empty-state p {
            margin-bottom: 2rem;
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.6);
            z-index: 1000;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(4px);
        }

        .modal.active {
            display: flex;
        }

        .modal-content {
            background: white;
            border-radius: var(--radius-2xl);
            padding: 2rem;
            max-width: 500px;
            width: 90%;
            box-shadow: var(--shadow-2xl);
            position: relative;
            animation: modalAppear 0.3s ease-out;
        }

        @keyframes modalAppear {
            from {
                opacity: 0;
                transform: scale(0.9) translateY(-20px);
            }
            to {
                opacity: 1;
                transform: scale(1) translateY(0);
            }
        }

        .modal-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--gray-200);
        }

        .modal-icon {
            width: 48px;
            height: 48px;
            background: var(--danger-100);
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--danger-600);
            font-size: 1.25rem;
        }

        .modal-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--gray-900);
        }

        .modal-message {
            color: var(--gray-600);
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .modal-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
        }

        .btn-secondary {
            background: var(--gray-100);
            color: var(--gray-700);
            padding: 0.75rem 1.5rem;
            border: 1px solid var(--gray-300);
            border-radius: var(--radius-lg);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background: var(--gray-200);
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--danger-500), var(--danger-600));
            color: white;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: var(--radius-lg);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-danger:hover {
            transform: translateY(-1px);
            box-shadow: var(--shadow-lg);
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .main-container {
                padding: 1rem;
            }

            .page-header {
                padding: 1.5rem;
            }

            .header-content {
                flex-direction: column;
                align-items: flex-start;
            }

            .header-stats {
                width: 100%;
                justify-content: space-between;
            }
        }

        @media (max-width: 768px) {
            .navbar-container {
                padding: 1rem;
                flex-wrap: wrap;
            }

            .navbar-nav {
                display: none;
            }

            .actions-bar {
                flex-direction: column;
                align-items: stretch;
            }

            .search-filters {
                flex-direction: column;
                gap: 1rem;
            }

            .data-table {
                font-size: 0.875rem;
            }

            .data-table th,
            .data-table td {
                padding: 1rem 0.75rem;
            }

            .user-cell {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }

            .actions-cell {
                flex-direction: column;
                gap: 0.25rem;
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

            <ul class="navbar-nav">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">
                    <i class="fas fa-tachometer-alt"></i>Dashboard
                </a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users" class="nav-link active">
                    <i class="fas fa-users"></i>Users
                </a></li>
                <li><a href="${pageContext.request.contextPath}/admin/reports" class="nav-link">
                    <i class="fas fa-chart-line"></i>Reports
                </a></li>
                <li><a href="${pageContext.request.contextPath}/inventory/dashboard" class="nav-link">
                    <i class="fas fa-boxes"></i>Inventory
                </a></li>
            </ul>

            <div class="navbar-actions">
                <div class="user-menu">
                    <div class="user-avatar">AD</div>
                    <div class="user-info">
                        <div class="user-name">Admin User</div>
                        <div class="user-role">Administrator</div>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main-container">
        <!-- Page Header -->
        <div class="page-header">
            <div class="header-content">
                <div class="header-info">
                    <h1>
                        <i class="fas fa-users"></i>
                        User Management
                    </h1>
                    <p>Manage system users, roles, and permissions</p>
                </div>
                <div class="header-stats">
                    <div class="stat-item">
                        <div class="stat-number">${totalUsers != null ? totalUsers : '0'}</div>
                        <div class="stat-label">Total Users</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">${activeUsers != null ? activeUsers : '0'}</div>
                        <div class="stat-label">Active Users</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">3</div>
                        <div class="stat-label">User Roles</div>
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

        <!-- Actions Bar -->
        <div class="actions-bar">
            <div class="search-filters">
                <div class="search-box">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" class="search-input" placeholder="Search users by name, email, or username..." id="userSearch">
                </div>
                <select class="filter-dropdown" id="roleFilter">
                    <option value="">All Roles</option>
                    <option value="admin">Admin</option>
                    <option value="pharmacist">Pharmacist</option>
                    <option value="cashier">Cashier</option>
                </select>
                <select class="filter-dropdown" id="statusFilter">
                    <option value="">All Status</option>
                    <option value="active">Active</option>
                    <option value="inactive">Inactive</option>
                </select>
            </div>
            <a href="${pageContext.request.contextPath}/admin/add-user" class="btn-primary">
                <i class="fas fa-user-plus"></i>
                Add New User
            </a>
        </div>

        <!-- Users Table -->
        <div class="table-container">
            <div class="table-header">
                <h3 class="table-title">System Users</h3>
                <div class="table-meta">
                    <c:choose>
                        <c:when test="${not empty users}">
                            <c:set var="count" value="0" />
                            <c:forEach items="${users}" var="user">
                                <c:set var="count" value="${count + 1}" />
                            </c:forEach>
                            Showing ${count} users
                        </c:when>
                        <c:otherwise>No users found</c:otherwise>
                    </c:choose>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty users}">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>User</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>
                                        <div class="user-cell">
                                            <div class="user-avatar-large" style="background: linear-gradient(135deg, ${user.role == 'admin' ? 'var(--danger-500), var(--danger-600)' : (user.role == 'pharmacist' ? 'var(--info-500), var(--info-600)' : 'var(--warning-500), var(--warning-600)')})">
                                                ${user.firstName.substring(0,1)}${user.lastName.substring(0,1)}
                                            </div>
                                            <div class="user-details">
                                                <h4>${user.firstName} ${user.lastName}</h4>
                                                <div class="user-id">ID: ${user.id}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="username-badge">${user.username}</span>
                                    </td>
                                    <td>${user.email}</td>
                                    <td>
                                        <span class="role-badge role-${user.role}">
                                            <c:choose>
                                                <c:when test="${user.role == 'admin'}">
                                                    <i class="fas fa-shield-alt"></i>
                                                </c:when>
                                                <c:when test="${user.role == 'pharmacist'}">
                                                    <i class="fas fa-user-md"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-cash-register"></i>
                                                </c:otherwise>
                                            </c:choose>
                                            ${user.role}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="status-badge ${user.active ? 'status-active' : 'status-inactive'}">
                                            <i class="fas fa-${user.active ? 'check' : 'times'}"></i>
                                            ${user.active ? 'Active' : 'Inactive'}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="actions-cell">
                                            <a href="${pageContext.request.contextPath}/admin/edit-user/${user.id}"
                                               class="btn-icon btn-edit" title="Edit User">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button type="button" class="btn-icon btn-delete"
                                                    title="Delete User"
                                                    onclick="openDeleteModal(${user.id}, '${user.firstName} ${user.lastName}')">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h3>No Users Found</h3>
                        <p>Start by adding your first user to the system.</p>
                        <a href="${pageContext.request.contextPath}/admin/add-user" class="btn-primary">
                            <i class="fas fa-user-plus"></i>
                            Add First User
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <!-- Delete Confirmation Modal -->
    <div class="modal" id="deleteModal">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-icon">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <h3 class="modal-title">Confirm Deletion</h3>
            </div>
            <p class="modal-message" id="deleteMessage">
                Are you sure you want to delete this user? This action cannot be undone.
            </p>
            <div class="modal-actions">
                <button type="button" class="btn-secondary" onclick="closeDeleteModal()">
                    Cancel
                </button>
                <form id="deleteForm" method="POST" style="display: inline;">
                    <button type="submit" class="btn-danger">
                        <i class="fas fa-trash"></i>
                        Delete User
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        // Auto-hide alert messages
        function hideAlert(alertId) {
            const alert = document.getElementById(alertId);
            if (alert) {
                setTimeout(() => {
                    alert.style.transition = 'all 0.5s ease';
                    alert.style.opacity = '0';
                    alert.style.transform = 'translateY(-8px)';
                    setTimeout(() => alert.remove(), 500);
                }, 5000);
            }
        }

        hideAlert('successAlert');
        hideAlert('errorAlert');

        // Search and filter functionality
        const searchInput = document.getElementById('userSearch');
        const roleFilter = document.getElementById('roleFilter');
        const statusFilter = document.getElementById('statusFilter');
        const tableRows = document.querySelectorAll('.data-table tbody tr');

        function filterTable() {
            const searchTerm = searchInput.value.toLowerCase();
            const roleValue = roleFilter.value.toLowerCase();
            const statusValue = statusFilter.value.toLowerCase();

            tableRows.forEach(row => {
                const userText = row.cells[0].textContent.toLowerCase();
                const usernameText = row.cells[1].textContent.toLowerCase();
                const emailText = row.cells[2].textContent.toLowerCase();
                const roleText = row.cells[3].textContent.toLowerCase();
                const statusText = row.cells[4].textContent.toLowerCase();

                const matchesSearch = !searchTerm ||
                    userText.includes(searchTerm) ||
                    usernameText.includes(searchTerm) ||
                    emailText.includes(searchTerm);

                const matchesRole = !roleValue || roleText.includes(roleValue);
                const matchesStatus = !statusValue ||
                    (statusValue === 'active' && statusText.includes('active')) ||
                    (statusValue === 'inactive' && statusText.includes('inactive'));

                if (matchesSearch && matchesRole && matchesStatus) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        if (searchInput) searchInput.addEventListener('input', filterTable);
        if (roleFilter) roleFilter.addEventListener('change', filterTable);
        if (statusFilter) statusFilter.addEventListener('change', filterTable);

        // Delete modal functionality
        function openDeleteModal(userId, userName) {
            const modal = document.getElementById('deleteModal');
            const message = document.getElementById('deleteMessage');
            const form = document.getElementById('deleteForm');

            message.textContent = `Are you sure you want to delete ${userName}? This action cannot be undone.`;
            form.action = '${pageContext.request.contextPath}/admin/delete-user/' + userId;
            modal.classList.add('active');
        }

        function closeDeleteModal() {
            const modal = document.getElementById('deleteModal');
            modal.classList.remove('active');
        }

        // Close modal on escape key
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') {
                closeDeleteModal();
            }
        });

        // Close modal when clicking outside
        document.getElementById('deleteModal').addEventListener('click', (e) => {
            if (e.target.classList.contains('modal')) {
                closeDeleteModal();
            }
        });

        // Prevent form double submission
        document.querySelectorAll('form').forEach(form => {
            form.addEventListener('submit', (e) => {
                const submitButton = form.querySelector('button[type="submit"]');
                if (submitButton) {
                    submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
                    submitButton.disabled = true;
                }
            });
        });
    </script>
</body>
</html>
