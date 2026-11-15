<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard – PharmaCare</title>
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

            --warning-50: #fffbeb;
            --warning-500: #f59e0b;
            --warning-600: #d97706;

            --danger-50: #fef2f2;
            --danger-500: #ef4444;
            --danger-600: #dc2626;

            --info-50: #f0f9ff;
            --info-500: #06b6d4;
            --info-600: #0891b2;

            --orange-50: #fff7ed;
            --orange-500: #f97316;
            --orange-600: #ea580c;

            --purple-50: #faf5ff;
            --purple-500: #a855f7;
            --purple-600: #9333ea;

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

        /* Dashboard Layout */
        .dashboard {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            width: 280px;
            background: linear-gradient(180deg, var(--primary-600) 0%, var(--primary-700) 100%);
            color: white;
            position: fixed;
            height: 100vh;
            left: 0;
            top: 0;
            z-index: 40;
            overflow-y: auto;
            box-shadow: var(--shadow-xl);
            transition: transform 0.3s ease-in-out;
        }

        .sidebar.mobile-hidden {
            transform: translateX(-100%);
        }

        .sidebar-header {
            padding: 2rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            background: rgba(0, 0, 0, 0.1);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .brand-icon {
            width: 48px;
            height: 48px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            backdrop-filter: blur(10px);
        }

        .brand-text h1 {
            font-size: 1.5rem;
            font-weight: 800;
            margin-bottom: 0.25rem;
        }

        .brand-text p {
            font-size: 0.875rem;
            opacity: 0.8;
            font-weight: 500;
        }

        /* Navigation */
        .nav-menu {
            padding: 1.5rem 0;
        }

        .nav-group {
            margin-bottom: 2rem;
        }

        .nav-group-title {
            padding: 0 2rem 0.75rem;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            opacity: 0.7;
        }

        .nav-item {
            display: flex;
            align-items: center;
            color: white;
            text-decoration: none;
            padding: 0.875rem 2rem;
            margin: 0.25rem 1rem;
            border-radius: var(--radius-lg);
            transition: all 0.3s ease;
            position: relative;
            font-weight: 500;
        }

        .nav-item:hover {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            transform: translateX(4px);
        }

        .nav-item.active {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            font-weight: 600;
        }

        .nav-item.active::before {
            content: '';
            position: absolute;
            left: -1rem;
            top: 50%;
            transform: translateY(-50%);
            width: 4px;
            height: 24px;
            background: white;
            border-radius: 2px;
        }

        .nav-item i {
            width: 20px;
            margin-right: 0.875rem;
            font-size: 1.125rem;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 280px;
            background: var(--gray-50);
            min-height: 100vh;
        }

        /* Header */
        .header {
            background: white;
            border-bottom: 1px solid var(--gray-200);
            padding: 1.5rem 2rem;
            position: sticky;
            top: 0;
            z-index: 30;
            box-shadow: var(--shadow-sm);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .mobile-menu-btn {
            display: none;
            background: var(--gray-100);
            border: none;
            border-radius: var(--radius-md);
            padding: 0.75rem;
            color: var(--gray-600);
            cursor: pointer;
            font-size: 1.25rem;
            transition: all 0.3s ease;
        }

        .mobile-menu-btn:hover {
            background: var(--gray-200);
        }

        .page-title {
            font-size: 1.875rem;
            font-weight: 800;
            color: var(--gray-900);
        }

        .page-subtitle {
            font-size: 0.875rem;
            color: var(--gray-500);
            margin-top: 0.25rem;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .notification-btn {
            position: relative;
            background: var(--gray-100);
            border: none;
            border-radius: var(--radius-lg);
            padding: 0.75rem;
            color: var(--gray-600);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .notification-btn:hover {
            background: var(--gray-200);
        }

        .notification-badge {
            position: absolute;
            top: 0.25rem;
            right: 0.25rem;
            width: 8px;
            height: 8px;
            background: var(--danger-500);
            border-radius: 50%;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.5rem;
            border-radius: var(--radius-lg);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .user-profile:hover {
            background: var(--gray-50);
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--primary-500), var(--primary-600));
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 0.875rem;
        }

        .user-info {
            display: flex;
            flex-direction: column;
        }

        .user-name {
            font-weight: 600;
            color: var(--gray-900);
            font-size: 0.875rem;
        }

        .user-role {
            font-size: 0.75rem;
            color: var(--gray-500);
        }

        /* Content Area */
        .content {
            padding: 2rem;
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
        }

        .alert.success {
            background: var(--success-50);
            border: 1px solid var(--success-200);
            color: var(--success-800);
        }

        .alert.error {
            background: var(--danger-50);
            border: 1px solid var(--danger-200);
            color: var(--danger-800);
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2.5rem;
        }

        .stat-card {
            background: white;
            border-radius: var(--radius-2xl);
            padding: 2rem;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--gray-200);
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-xl);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-500), var(--secondary-500));
        }

        .stat-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
        }

        .stat-icon {
            width: 56px;
            height: 56px;
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
            position: relative;
        }

        .stat-icon.users { background: linear-gradient(135deg, var(--primary-500), var(--primary-600)); }
        .stat-icon.active { background: linear-gradient(135deg, var(--secondary-500), var(--secondary-600)); }
        .stat-icon.pharmacists { background: linear-gradient(135deg, var(--info-500), var(--info-600)); }
        .stat-icon.cashiers { background: linear-gradient(135deg, var(--warning-500), var(--warning-600)); }

        .stat-trend {
            font-size: 0.75rem;
            font-weight: 600;
            padding: 0.25rem 0.5rem;
            border-radius: 9999px;
            background: var(--success-50);
            color: var(--success-600);
        }

        .stat-content {
            margin-bottom: 1rem;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--gray-900);
            margin-bottom: 0.5rem;
            line-height: 1;
        }

        .stat-label {
            font-size: 0.875rem;
            color: var(--gray-600);
            font-weight: 500;
        }

        .stat-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-top: 1rem;
            border-top: 1px solid var(--gray-100);
        }

        .stat-change {
            font-size: 0.75rem;
            font-weight: 500;
            color: var(--success-600);
        }

        .stat-period {
            font-size: 0.75rem;
            color: var(--gray-400);
        }

        /* Action Cards Grid */
        .actions-section {
            margin-top: 2rem;
        }

        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 2rem;
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--gray-900);
        }

        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
        }

        .action-card {
            background: white;
            border-radius: var(--radius-xl);
            border: 2px solid var(--gray-200);
            overflow: hidden;
            transition: all 0.3s ease;
            position: relative;
        }

        .action-card:hover {
            border-color: var(--primary-300);
            transform: translateY(-4px);
            box-shadow: var(--shadow-xl);
        }

        .action-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.8), transparent);
            transition: left 0.6s;
        }

        .action-card:hover::before {
            left: 100%;
        }

        .action-link {
            display: block;
            padding: 2rem;
            text-decoration: none;
            color: inherit;
            height: 100%;
        }

        .action-header {
            display: flex;
            align-items: flex-start;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .action-icon {
            width: 56px;
            height: 56px;
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
            flex-shrink: 0;
        }

        .action-icon.primary { background: linear-gradient(135deg, var(--primary-500), var(--primary-600)); }
        .action-icon.secondary { background: linear-gradient(135deg, var(--secondary-500), var(--secondary-600)); }
        .action-icon.info { background: linear-gradient(135deg, var(--info-500), var(--info-600)); }
        .action-icon.warning { background: linear-gradient(135deg, var(--warning-500), var(--warning-600)); }
        .action-icon.danger { background: linear-gradient(135deg, var(--danger-500), var(--danger-600)); }
        .action-icon.orange { background: linear-gradient(135deg, var(--orange-500), var(--orange-600)); }
        .action-icon.purple { background: linear-gradient(135deg, var(--purple-500), var(--purple-600)); }

        .action-content h3 {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--gray-900);
            margin-bottom: 0.5rem;
        }

        .action-content p {
            font-size: 0.875rem;
            color: var(--gray-600);
            line-height: 1.5;
        }

        .action-footer {
            margin-top: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .action-meta {
            font-size: 0.75rem;
            color: var(--gray-400);
        }

        .action-arrow {
            color: var(--primary-500);
            font-size: 1.125rem;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .sidebar {
                transform: translateX(-100%);
            }

            .sidebar.mobile-visible {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .mobile-menu-btn {
                display: block;
            }
        }

        @media (max-width: 768px) {
            .header {
                padding: 1rem 1.5rem;
            }

            .content {
                padding: 1.5rem;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .actions-grid {
                grid-template-columns: 1fr;
            }

            .user-info {
                display: none;
            }

            .page-title {
                font-size: 1.5rem;
            }
        }

        @media (max-width: 480px) {
            .header {
                padding: 1rem;
            }

            .content {
                padding: 1rem;
            }

            .stat-card {
                padding: 1.5rem;
            }

            .action-link {
                padding: 1.5rem;
            }

            .stat-number {
                font-size: 2rem;
            }
        }

        /* Sidebar overlay for mobile */
        .sidebar-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.5);
            z-index: 35;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .sidebar-overlay.active {
            opacity: 1;
            visibility: visible;
        }
    </style>
</head>

<body>
    <div class="dashboard">
        <!-- Sidebar Overlay -->
        <div class="sidebar-overlay" id="sidebarOverlay"></div>

        <!-- Sidebar -->
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <div class="brand">
                    <div class="brand-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <div class="brand-text">
                        <h1>PharmaCare</h1>
                        <p>Admin Panel</p>
                    </div>
                </div>
            </div>

            <nav class="nav-menu">
                <div class="nav-group">
                    <div class="nav-group-title">Main</div>
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item active">
                        <i class="fas fa-tachometer-alt"></i>
                        Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/analytics" class="nav-item">
                        <i class="fas fa-chart-line"></i>
                        Analytics
                    </a>
                </div>

                <div class="nav-group">
                    <div class="nav-group-title">Management</div>
                    <a href="${pageContext.request.contextPath}/admin/users" class="nav-item">
                        <i class="fas fa-users"></i>
                        User Management
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/offers" class="nav-item">
                        <i class="fas fa-tags"></i>
                        Offers & Promotions
                    </a>
                    <a href="${pageContext.request.contextPath}/inventory/dashboard" class="nav-item">
                        <i class="fas fa-boxes"></i>
                        Inventory
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/reports" class="nav-item">
                        <i class="fas fa-file-chart-column"></i>
                        Reports
                    </a>
                </div>

                <div class="nav-group">
                    <div class="nav-group-title">System</div>
                    <a href="${pageContext.request.contextPath}/admin/settings" class="nav-item">
                        <i class="fas fa-cog"></i>
                        Settings
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/logs" class="nav-item">
                        <i class="fas fa-list-alt"></i>
                        System Logs
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="nav-item">
                        <i class="fas fa-sign-out-alt"></i>
                        Logout
                    </a>
                </div>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Header -->
            <header class="header">
                <div class="header-left">
                    <button class="mobile-menu-btn" id="mobileMenuBtn">
                        <i class="fas fa-bars"></i>
                    </button>
                    <div>
                        <h1 class="page-title">Dashboard Overview</h1>
                        <div class="page-subtitle">Monitor your pharmacy management system</div>
                    </div>
                </div>

                <div class="header-right">
                    <button class="notification-btn">
                        <i class="fas fa-bell"></i>
                        <span class="notification-badge"></span>
                    </button>

                    <div class="user-profile">
                        <div class="user-avatar">
                            AD
                        </div>
                        <div class="user-info">
                            <div class="user-name">Admin User</div>
                            <div class="user-role">Administrator</div>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Content -->
            <div class="content">
                <!-- Alert Messages -->
                <c:if test="${not empty success}">
                    <div class="alert success">
                        <i class="fas fa-check-circle"></i>
                        <span>${success}</span>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert error">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>${error}</span>
                    </div>
                </c:if>

                <!-- Stats Grid -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-header">
                            <div class="stat-icon users">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="stat-trend">+12%</div>
                        </div>
                        <div class="stat-content">
                            <div class="stat-number">${totalUsers != null ? totalUsers : '156'}</div>
                            <div class="stat-label">Total Users</div>
                        </div>
                        <div class="stat-footer">
                            <div class="stat-change">+8 this week</div>
                            <div class="stat-period">Last 7 days</div>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-header">
                            <div class="stat-icon active">
                                <i class="fas fa-user-check"></i>
                            </div>
                            <div class="stat-trend">+5%</div>
                        </div>
                        <div class="stat-content">
                            <div class="stat-number">${activeUsers != null ? activeUsers : '142'}</div>
                            <div class="stat-label">Active Users</div>
                        </div>
                        <div class="stat-footer">
                            <div class="stat-change">+3 today</div>
                            <div class="stat-period">Last 24 hours</div>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-header">
                            <div class="stat-icon pharmacists">
                                <i class="fas fa-user-md"></i>
                            </div>
                            <div class="stat-trend">+2%</div>
                        </div>
                        <div class="stat-content">
                            <div class="stat-number">${totalPharmacists != null ? totalPharmacists : '12'}</div>
                            <div class="stat-label">Pharmacists</div>
                        </div>
                        <div class="stat-footer">
                            <div class="stat-change">+1 this month</div>
                            <div class="stat-period">Last 30 days</div>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-header">
                            <div class="stat-icon cashiers">
                                <i class="fas fa-cash-register"></i>
                            </div>
                            <div class="stat-trend">+8%</div>
                        </div>
                        <div class="stat-content">
                            <div class="stat-number">${totalCashiers != null ? totalCashiers : '8'}</div>
                            <div class="stat-label">Cashiers</div>
                        </div>
                        <div class="stat-footer">
                            <div class="stat-change">+2 this month</div>
                            <div class="stat-period">Last 30 days</div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="actions-section">
                    <div class="section-header">
                        <h2 class="section-title">Quick Actions</h2>
                    </div>

                    <div class="actions-grid">
                        <div class="action-card">
                            <a href="<c:url value='/admin/loyalty-members'/>" class="action-link">
                                <div class="action-header">
                                    <div class="action-icon secondary">
                                        <i class="fas fa-crown"></i>
                                    </div>
                                    <div class="action-content">
                                        <h3>Loyalty Members</h3>
                                        <p>View premium members, points and full transaction history. Remove membership if needed.</p>
                                    </div>
                                </div>
                                <div class="action-footer">
                                    <div class="action-meta">Membership & points</div>
                                    <div class="action-arrow">
                                        <i class="fas fa-arrow-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <div class="action-card">
                            <a href="<c:url value='/admin/guests'/>" class="action-link">
                                <div class="action-header">
                                    <div class="action-icon info">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <div class="action-content">
                                        <h3>Guest Customers</h3>
                                        <p>View and manage non-members. Review payment history and delete records.</p>
                                    </div>
                                </div>
                                <div class="action-footer">
                                    <div class="action-meta">Customers without membership</div>
                                    <div class="action-arrow">
                                        <i class="fas fa-arrow-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="action-card">
                            <a href="${pageContext.request.contextPath}/admin/users" class="action-link">
                                <div class="action-header">
                                    <div class="action-icon primary">
                                        <i class="fas fa-users"></i>
                                    </div>
                                    <div class="action-content">
                                        <h3>User Management</h3>
                                        <p>Manage pharmacists, cashiers, and system users. View profiles and permissions.</p>
                                    </div>
                                </div>
                                <div class="action-footer">
                                    <div class="action-meta">156 total users</div>
                                    <div class="action-arrow">
                                        <i class="fas fa-arrow-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <div class="action-card">
                            <a href="${pageContext.request.contextPath}/admin/add-user" class="action-link">
                                <div class="action-header">
                                    <div class="action-icon secondary">
                                        <i class="fas fa-user-plus"></i>
                                    </div>
                                    <div class="action-content">
                                        <h3>Add New User</h3>
                                        <p>Create new user accounts for staff members with appropriate role assignments.</p>
                                    </div>
                                </div>
                                <div class="action-footer">
                                    <div class="action-meta">Quick setup</div>
                                    <div class="action-arrow">
                                        <i class="fas fa-arrow-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <div class="action-card">
                            <a href="${pageContext.request.contextPath}/admin/offers" class="action-link">
                                <div class="action-header">
                                    <div class="action-icon orange">
                                        <i class="fas fa-tags"></i>
                                    </div>
                                    <div class="action-content">
                                        <h3>Offers & Promotions</h3>
                                        <p>Create and manage special offers, discounts, and promotional campaigns for medicines.</p>
                                    </div>
                                </div>
                                <div class="action-footer">
                                    <div class="action-meta">Active campaigns</div>
                                    <div class="action-arrow">
                                        <i class="fas fa-arrow-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <div class="action-card">
                            <a href="${pageContext.request.contextPath}/inventory/dashboard" class="action-link">
                                <div class="action-header">
                                    <div class="action-icon info">
                                        <i class="fas fa-boxes"></i>
                                    </div>
                                    <div class="action-content">
                                        <h3>Inventory Management</h3>
                                        <p>Monitor stock levels, manage medicine categories, and track expiration dates.</p>
                                    </div>
                                </div>
                                <div class="action-footer">
                                    <div class="action-meta">Real-time tracking</div>
                                    <div class="action-arrow">
                                        <i class="fas fa-arrow-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <div class="action-card">
                            <a href="${pageContext.request.contextPath}/admin/reports" class="action-link">
                                <div class="action-header">
                                    <div class="action-icon warning">
                                        <i class="fas fa-chart-line"></i>
                                    </div>
                                    <div class="action-content">
                                        <h3>Analytics & Reports</h3>
                                        <p>Generate comprehensive reports on sales, inventory, and system performance.</p>
                                    </div>
                                </div>
                                <div class="action-footer">
                                    <div class="action-meta">Export available</div>
                                    <div class="action-arrow">
                                        <i class="fas fa-arrow-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <div class="action-card">
                            <a href="${pageContext.request.contextPath}/admin/settings" class="action-link">
                                <div class="action-header">
                                    <div class="action-icon primary">
                                        <i class="fas fa-cogs"></i>
                                    </div>
                                    <div class="action-content">
                                        <h3>System Settings</h3>
                                        <p>Configure application settings, security policies, and system preferences.</p>
                                    </div>
                                </div>
                                <div class="action-footer">
                                    <div class="action-meta">Administrative access</div>
                                    <div class="action-arrow">
                                        <i class="fas fa-arrow-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <div class="action-card">
                            <a href="${pageContext.request.contextPath}/profile" class="action-link">
                                <div class="action-header">
                                    <div class="action-icon secondary">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <div class="action-content">
                                        <h3>My Profile</h3>
                                        <p>Update your personal information, password, and account preferences.</p>
                                    </div>
                                </div>
                                <div class="action-footer">
                                    <div class="action-meta">Personal settings</div>
                                    <div class="action-arrow">
                                        <i class="fas fa-arrow-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>

                        <div class="action-card">
                            <a href="${pageContext.request.contextPath}/admin/offers" class="action-link">
                                <div class="action-header">
                                    <div class="action-icon purple">
                                        <i class="fas fa-plus-circle"></i>
                                    </div>
                                    <div class="action-content">
                                        <h3>Create New Offer</h3>
                                        <p>Launch new promotional campaigns with discounts, BOGO deals, and seasonal offers.</p>
                                    </div>
                                </div>
                                <div class="action-footer">
                                    <div class="action-meta">Marketing tool</div>
                                    <div class="action-arrow">
                                        <i class="fas fa-arrow-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Mobile menu toggle
        const mobileMenuBtn = document.getElementById('mobileMenuBtn');
        const sidebar = document.getElementById('sidebar');
        const sidebarOverlay = document.getElementById('sidebarOverlay');

        function toggleSidebar() {
            sidebar.classList.toggle('mobile-visible');
            sidebarOverlay.classList.toggle('active');
        }

        function closeSidebar() {
            sidebar.classList.remove('mobile-visible');
            sidebarOverlay.classList.remove('active');
        }

        mobileMenuBtn.addEventListener('click', toggleSidebar);
        sidebarOverlay.addEventListener('click', closeSidebar);

        // Close sidebar when clicking on nav items on mobile
        document.querySelectorAll('.nav-item').forEach(item => {
            item.addEventListener('click', () => {
                if (window.innerWidth <= 1024) {
                    closeSidebar();
                }
            });
        });

        // Handle window resize
        window.addEventListener('resize', () => {
            if (window.innerWidth > 1024) {
                closeSidebar();
            }
        });

        // Add hover effects and animations
        document.addEventListener('DOMContentLoaded', function() {
            // Animate stat cards on scroll
            const statCards = document.querySelectorAll('.stat-card');
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            });

            statCards.forEach(card => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                observer.observe(card);
            });
        });
    </script>
</body>
</html>
