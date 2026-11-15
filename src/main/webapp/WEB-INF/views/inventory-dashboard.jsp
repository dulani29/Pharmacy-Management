<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Inventory Dashboard | PharmaCare Management</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            /* Sophisticated Neutral Palette */
            --primary-dark: #2c3e50;
            --primary-medium: #34495e;
            --primary-light: #ecf0f1;

            --secondary-dark: #4a5568;
            --secondary-medium: #718096;
            --secondary-light: #e2e8f0;

            --background-main: #f8fafc;
            --background-card: #ffffff;
            --background-subtle: #f1f5f9;

            --text-primary: #1a202c;
            --text-secondary: #4a5568;
            --text-muted: #718096;

            --border-light: #e2e8f0;
            --border-medium: #cbd5e0;
            --border-dark: #a0aec0;

            --accent-blue: #4299e1;
            --accent-teal: #38b2ac;
            --accent-amber: #d69e2e;
            --accent-red: #e53e3e;

            --shadow-subtle: 0 1px 3px rgba(0, 0, 0, 0.05);
            --shadow-card: 0 4px 6px rgba(0, 0, 0, 0.05);
            --shadow-elevated: 0 10px 15px rgba(0, 0, 0, 0.08);
            --shadow-focus: 0 0 0 3px rgba(66, 153, 225, 0.1);

            --radius-sm: 6px;
            --radius-md: 8px;
            --radius-lg: 12px;
            --radius-xl: 16px;

            --transition-fast: 0.15s ease;
            --transition-smooth: 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background-color: var(--background-main);
            color: var(--text-primary);
            line-height: 1.6;
            font-weight: 400;
        }

        /* Header Navigation */
        .navbar {
            background: var(--background-card);
            border-bottom: 1px solid var(--border-light);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 100;
            backdrop-filter: blur(10px);
        }

        .navbar-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .nav-brand {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--primary-dark);
            text-decoration: none;
        }

        .nav-brand i {
            font-size: 1.5rem;
            color: var(--secondary-medium);
        }

        .nav-links {
            display: flex;
            gap: 0.5rem;
        }

        .nav-link {
            padding: 0.75rem 1.25rem;
            color: var(--text-secondary);
            text-decoration: none;
            border-radius: var(--radius-md);
            font-weight: 500;
            font-size: 0.875rem;
            transition: var(--transition-smooth);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .nav-link:hover {
            background-color: var(--background-subtle);
            color: var(--text-primary);
        }

        .nav-link.active {
            background-color: var(--primary-light);
            color: var(--primary-dark);
        }

        /* Main Container */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Page Header */
        .page-header {
            background: var(--background-card);
            border: 1px solid var(--border-light);
            border-radius: var(--radius-xl);
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-card);
        }

        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .page-title i {
            color: var(--secondary-medium);
        }

        .page-description {
            color: var(--text-secondary);
            font-size: 1rem;
            line-height: 1.5;
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
        }

        .alert.success {
            background: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }

        .alert.error {
            background: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }

        /* Statistics Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: var(--background-card);
            border: 1px solid var(--border-light);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            box-shadow: var(--shadow-card);
            transition: var(--transition-smooth);
        }

        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-elevated);
            border-color: var(--border-medium);
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
        }

        .stat-icon.total {
            background: var(--secondary-light);
            color: var(--secondary-dark);
        }

        .stat-icon.low-stock {
            background: #fed7d7;
            color: var(--accent-red);
        }

        .stat-icon.categories {
            background: #bee3f8;
            color: var(--accent-blue);
        }

        .stat-icon.restock {
            background: #c6f6d5;
            color: var(--accent-teal);
        }

        .stat-title {
            font-size: 0.875rem;
            font-weight: 500;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-value {
            font-size: 2.25rem;
            font-weight: 700;
            color: var(--text-primary);
            line-height: 1;
        }

        .stat-value.danger {
            color: var(--accent-red);
        }

        /* Search and Actions */
        .actions-bar {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            align-items: center;
            flex-wrap: wrap;
        }

        .search-form {
            position: relative;
            flex: 1;
            min-width: 300px;
            display: flex;
            gap: 1rem;
        }

        .search-container {
            position: relative;
            flex: 1;
        }

        .search-input {
            width: 100%;
            padding: 1rem 1rem 1rem 3rem;
            border: 2px solid var(--border-medium);
            border-radius: var(--radius-lg);
            font-size: 0.875rem;
            background: var(--background-card);
            transition: var(--transition-fast);
            font-weight: 400;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--accent-blue);
            box-shadow: var(--shadow-focus);
        }

        .search-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 1rem;
        }

        .btn {
            padding: 1rem 1.5rem;
            border: none;
            border-radius: var(--radius-md);
            font-weight: 500;
            font-size: 0.875rem;
            cursor: pointer;
            text-decoration: none;
            transition: var(--transition-smooth);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            white-space: nowrap;
        }

        .btn-primary {
            background: var(--primary-dark);
            color: white;
        }

        .btn-primary:hover {
            background: var(--primary-medium);
            transform: translateY(-1px);
            box-shadow: var(--shadow-card);
        }

        .btn-secondary {
            background: var(--secondary-medium);
            color: white;
        }

        .btn-secondary:hover {
            background: var(--secondary-dark);
            transform: translateY(-1px);
            box-shadow: var(--shadow-card);
        }

        .btn-success {
            background: var(--accent-teal);
            color: white;
        }

        .btn-success:hover {
            background: #2c7a7b;
            transform: translateY(-1px);
            box-shadow: var(--shadow-card);
        }

        .btn-danger {
            background: var(--accent-red);
            color: white;
        }

        .btn-danger:hover {
            background: #c53030;
        }

        .btn-outline {
            background: transparent;
            border: 1px solid var(--border-medium);
            color: var(--text-secondary);
        }

        .btn-outline:hover {
            background: var(--background-subtle);
            border-color: var(--border-dark);
        }

        /* Medicine Grid */
        .content-grid {
            display: grid;
            grid-template-columns: 1fr 320px;
            gap: 2rem;
        }

        @media (max-width: 1200px) {
            .content-grid {
                grid-template-columns: 1fr;
            }
        }

        .medicine-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 1.5rem;
        }

        @media (max-width: 768px) {
            .medicine-grid {
                grid-template-columns: 1fr;
            }
        }

        .medicine-card {
            background: var(--background-card);
            border: 1px solid var(--border-light);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            box-shadow: var(--shadow-card);
            transition: var(--transition-smooth);
            position: relative;
        }

        .medicine-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-elevated);
            border-color: var(--border-medium);
        }

        .medicine-card.low-stock {
            border-left: 4px solid var(--accent-red);
            background: #fffbfb;
        }

        .medicine-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1rem;
        }

        .medicine-name {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
        }

        .medicine-category {
            display: inline-block;
            background: var(--background-subtle);
            color: var(--text-secondary);
            padding: 0.25rem 0.75rem;
            border-radius: var(--radius-sm);
            font-size: 0.75rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .medicine-type {
            background: var(--secondary-light);
            color: var(--secondary-dark);
            padding: 0.5rem 1rem;
            border-radius: var(--radius-md);
            font-size: 0.875rem;
            font-weight: 500;
        }

        .medicine-details {
            margin: 1rem 0;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem 0;
            border-bottom: 1px solid var(--border-light);
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.875rem;
            color: var(--text-secondary);
            font-weight: 500;
        }

        .detail-label i {
            width: 16px;
            color: var(--text-muted);
        }

        .detail-value {
            font-size: 0.875rem;
            font-weight: 500;
            color: var(--text-primary);
        }

        .detail-value.price {
            font-weight: 600;
            color: var(--accent-blue);
        }

        .detail-value.stock-low {
            color: var(--accent-red);
            font-weight: 600;
        }

        .detail-value.stock-good {
            color: var(--accent-teal);
            font-weight: 600;
        }

        .medicine-actions {
            display: flex;
            gap: 0.75rem;
            margin-top: 1.5rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border-light);
        }

        .btn-sm {
            padding: 0.5rem 1rem;
            font-size: 0.75rem;
            flex: 1;
        }

        /* Sidebar */
        .sidebar {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .sidebar-card {
            background: var(--background-card);
            border: 1px solid var(--border-light);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            box-shadow: var(--shadow-card);
        }

        .sidebar-title {
            font-size: 1rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .alert-list {
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .alert-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.75rem 0;
            border-bottom: 1px solid var(--border-light);
        }

        .alert-item:last-child {
            border-bottom: none;
        }

        .alert-info {
            display: flex;
            flex-direction: column;
        }

        .alert-name {
            font-size: 0.875rem;
            font-weight: 500;
            color: var(--text-primary);
        }

        .alert-status {
            font-size: 0.75rem;
            color: var(--text-muted);
        }

        .alert-badge {
            background: var(--accent-red);
            color: white;
            padding: 0.25rem 0.5rem;
            border-radius: var(--radius-sm);
            font-size: 0.75rem;
            font-weight: 600;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--text-muted);
            background: var(--background-card);
            border: 1px solid var(--border-light);
            border-radius: var(--radius-lg);
        }

        .empty-icon {
            font-size: 3rem;
            color: var(--text-muted);
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .empty-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-secondary);
            margin-bottom: 0.5rem;
        }

        .empty-description {
            margin-bottom: 2rem;
        }

        /* Search Results */
        .search-results-info {
            background: var(--background-card);
            border: 1px solid var(--border-light);
            border-radius: var(--radius-lg);
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .search-results-text {
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        .clear-search {
            color: var(--accent-blue);
            text-decoration: none;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .clear-search:hover {
            text-decoration: underline;
        }

        /* Notification */
        .notification {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            background: var(--background-card);
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-lg);
            padding: 1rem 1.5rem;
            box-shadow: var(--shadow-elevated);
            display: none;
            align-items: center;
            gap: 0.75rem;
            z-index: 1000;
            max-width: 400px;
        }

        .notification.show {
            display: flex;
            animation: slideInRight 0.3s ease;
        }

        .notification.success {
            border-left: 4px solid var(--accent-teal);
        }

        .notification.error {
            border-left: 4px solid var(--accent-red);
        }

        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        /* DEBUG STYLES */
        .debug-info {
            background: #fff3cd;
            border: 1px solid #ffc107;
            padding: 1rem;
            margin: 1rem 0;
            border-radius: var(--radius-md);
            font-family: monospace;
            font-size: 0.875rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .navbar-container {
                padding: 0 1rem;
                flex-direction: column;
                gap: 1rem;
            }

            .nav-links {
                justify-content: center;
                flex-wrap: wrap;
            }

            .actions-bar {
                flex-direction: column;
                align-items: stretch;
            }

            .search-form {
                min-width: auto;
                flex-direction: column;
            }

            .stats-grid {
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            }

            .page-header {
                padding: 1.5rem;
            }

            .page-title {
                font-size: 1.5rem;
            }
        }

        /* Focus and Accessibility */
        .btn:focus,
        .search-input:focus,
        .nav-link:focus {
            outline: 2px solid var(--accent-blue);
            outline-offset: 2px;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="navbar-container">
            <a href="#" class="nav-brand">
                <i class="fas fa-capsules"></i>
                Inventory Manager
            </a>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/inventory/dashboard" class="nav-link active">
                    <i class="fas fa-boxes"></i>
                    Inventory
                </a>
                <a href="${pageContext.request.contextPath}/inventory/add-stock" class="nav-link">
                    <i class="fas fa-plus"></i>
                    Add Stock
                </a>
                <a href="${pageContext.request.contextPath}/inventory/orders" class="nav-link">
                    <i class="fas fa-truck"></i>
                    Orders
                </a>
                <a href="${pageContext.request.contextPath}/inventory/reports" class="nav-link">
                    <i class="fas fa-chart-bar"></i>
                    Reports
                </a>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">
                    <i class="fas fa-tachometer-alt"></i>
                    Admin Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="nav-link">
                    <i class="fas fa-sign-out-alt"></i>
                    Logout
                </a>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">
                <i class="fas fa-boxes"></i>
                Inventory Dashboard
            </h1>
            <p class="page-description">
                Monitor your pharmaceutical inventory, track stock levels, and manage medicine information efficiently.
                Keep your pharmacy well-stocked to serve patients effectively.
            </p>
        </div>

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

        <!-- DEBUG INFO (Remove this in production) -->


        <!-- Statistics -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon total">
                        <i class="fas fa-prescription-bottle"></i>
                    </div>
                </div>
                <div class="stat-title">Total Medicines</div>
                <div class="stat-value">${medicines != null ? medicines.size() : 0}</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon low-stock">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                </div>
                <div class="stat-title">Low Stock Alerts</div>
                <div class="stat-value danger">${lowStockItems != null ? lowStockItems.size() : 0}</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon categories">
                        <i class="fas fa-tags"></i>
                    </div>
                </div>
                <div class="stat-title">Categories</div>
                <div class="stat-value">${totalCategories != null ? totalCategories : 0}</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon restock">
                        <i class="fas fa-sync"></i>
                    </div>
                </div>
                <div class="stat-title">Recently Restocked</div>
                <div class="stat-value">${recentRestock != null ? recentRestock : 0}</div>
            </div>
        </div>

        <!-- Actions Bar -->
        <div class="actions-bar">
            <form class="search-form" method="get" action="${pageContext.request.contextPath}/inventory/dashboard">
                <div class="search-container">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text"
                           name="search"
                           class="search-input"
                           placeholder="Search medicines, companies, categories..."
                           value="${param.search}">
                </div>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-search"></i>
                    Search
                </button>
            </form>
            <a href="${pageContext.request.contextPath}/inventory/add-stock" class="btn btn-secondary">
                <i class="fas fa-plus"></i>
                Add Medicine
            </a>
        </div>

        <!-- Search Results Info -->
        <c:if test="${param.search != null && not empty param.search}">
            <div class="search-results-info">
                <span class="search-results-text">
                    <i class="fas fa-search"></i>
                    Search results for "<strong>${param.search}</strong>"
                    (${medicines != null ? medicines.size() : 0} found)
                </span>
                <a href="${pageContext.request.contextPath}/inventory/dashboard" class="clear-search">
                    <i class="fas fa-times"></i> Clear Search
                </a>
            </div>
        </c:if>

        <!-- Content Grid -->
        <div class="content-grid">
            <!-- Main Content -->
            <div class="main-content">
                <c:choose>
                    <c:when test="${medicines != null && medicines.size() > 0}">
                        <div class="medicine-grid">
                            <c:forEach items="${medicines}" var="medicine" varStatus="status">
                                <div class="medicine-card ${(medicine.quantity != null && medicine.minimumStock != null && medicine.quantity <= medicine.minimumStock) ? 'low-stock' : ''}">
                                    <div class="medicine-header">
                                        <div>
                                            <h3 class="medicine-name">
                                                <c:choose>
                                                    <c:when test="${not empty medicine.name}">
                                                        ${medicine.name}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Medicine #${medicine.id}
                                                    </c:otherwise>
                                                </c:choose>
                                            </h3>
                                            <span class="medicine-category">
                                                <c:choose>
                                                    <c:when test="${not empty medicine.category}">
                                                        ${medicine.category}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Uncategorized
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                        <div class="medicine-type">
                                            <c:choose>
                                                <c:when test="${not empty medicine.type}">
                                                    ${medicine.type}
                                                </c:when>
                                                <c:otherwise>
                                                    Medicine
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>

                                    <div class="medicine-details">
                                        <div class="detail-row">
                                            <div class="detail-label">
                                                <i class="fas fa-building"></i>
                                                Company
                                            </div>
                                            <div class="detail-value">
                                                <c:choose>
                                                    <c:when test="${not empty medicine.company}">
                                                        ${medicine.company}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Unknown
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="detail-row">
                                            <div class="detail-label">
                                                <i class="fas fa-dollar-sign"></i>
                                                Price
                                            </div>
                                            <div class="detail-value price">
                                                Rs. <c:choose>
                                                        <c:when test="${medicine.price != null}">
                                                            <fmt:formatNumber value="${medicine.price}" pattern="#,##0.00"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            0.00
                                                        </c:otherwise>
                                                    </c:choose>
                                            </div>
                                        </div>
                                        <div class="detail-row">
                                            <div class="detail-label">
                                                <i class="fas fa-calendar"></i>
                                                Expiry Date
                                            </div>
                                            <div class="detail-value">
                                                <c:choose>
                                                    <c:when test="${medicine.expiryDate != null}">
                                                        ${medicine.expiryDate}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Not specified
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="detail-row">
                                            <div class="detail-label">
                                                <i class="fas fa-boxes"></i>
                                                Current Stock
                                            </div>
                                            <div class="detail-value ${(medicine.quantity != null && medicine.minimumStock != null && medicine.quantity <= medicine.minimumStock) ? 'stock-low' : 'stock-good'}">
                                                <c:choose>
                                                    <c:when test="${medicine.quantity != null}">
                                                        ${medicine.quantity} units
                                                    </c:when>
                                                    <c:otherwise>
                                                        0 units
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="detail-row">
                                            <div class="detail-label">
                                                <i class="fas fa-layer-group"></i>
                                                Minimum Stock
                                            </div>
                                            <div class="detail-value">
                                                <c:choose>
                                                    <c:when test="${medicine.minimumStock != null}">
                                                        ${medicine.minimumStock} units
                                                    </c:when>
                                                    <c:otherwise>
                                                        0 units
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="medicine-actions">
                                        <form action="${pageContext.request.contextPath}/inventory/restock/${medicine.id}" method="post" style="flex: 1;">
                                            <button type="submit" class="btn btn-success btn-sm" style="width: 100%;">
                                                <i class="fas fa-plus"></i>
                                                Restock
                                            </button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/inventory/delete/${medicine.id}"
                                              method="post"
                                              style="flex: 1;"
                                              onsubmit="return confirm('Are you sure you want to delete ${medicine.name}? This action cannot be undone.')">
                                            <button type="submit" class="btn btn-danger btn-sm" style="width: 100%;">
                                                <i class="fas fa-trash"></i>
                                                Delete
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="empty-icon">
                                <i class="fas fa-box-open"></i>
                            </div>
                            <h2 class="empty-title">
                                <c:choose>
                                    <c:when test="${param.search != null && not empty param.search}">
                                        No Results Found
                                    </c:when>
                                    <c:otherwise>
                                        No Medicines Found
                                    </c:otherwise>
                                </c:choose>
                            </h2>
                            <p class="empty-description">
                                <c:choose>
                                    <c:when test="${param.search != null && not empty param.search}">
                                        No medicines found matching "${param.search}". Try different keywords or check spelling.
                                    </c:when>
                                    <c:otherwise>
                                        Your inventory appears to be empty. Start by adding some medicines to get started.
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <c:choose>
                                <c:when test="${param.search != null && not empty param.search}">
                                    <a href="${pageContext.request.contextPath}/inventory/dashboard" class="btn btn-primary">
                                        <i class="fas fa-arrow-left"></i>
                                        View All Medicines
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/inventory/add-stock" class="btn btn-primary">
                                        <i class="fas fa-plus"></i>
                                        Add First Medicine
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Sidebar -->
            <div class="sidebar">
                <!-- Low Stock Alerts -->
                <div class="sidebar-card">
                    <h2 class="sidebar-title">
                        <i class="fas fa-exclamation-triangle"></i>
                        Low Stock Alerts
                    </h2>
                    <c:choose>
                        <c:when test="${lowStockItems != null && lowStockItems.size() > 0}">
                            <ul class="alert-list">
                                <c:forEach items="${lowStockItems}" var="item">
                                    <li class="alert-item">
                                        <div class="alert-info">
                                            <span class="alert-name">${item.name}</span>
                                            <span class="alert-status">Min: ${item.minimumStock != null ? item.minimumStock : 0} units</span>
                                        </div>
                                        <span class="alert-badge">${item.quantity != null ? item.quantity : 0} left</span>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <p style="color: var(--text-muted); font-size: 0.875rem; font-style: italic;">
                                All medicines are adequately stocked.
                            </p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Quick Actions -->
                <div class="sidebar-card">
                    <h2 class="sidebar-title">
                        <i class="fas fa-bolt"></i>
                        Quick Actions
                    </h2>
                    <div style="display: flex; flex-direction: column; gap: 0.75rem;">
                        <a href="${pageContext.request.contextPath}/inventory/add-stock" class="btn btn-outline">
                            <i class="fas fa-plus"></i>
                            Add New Medicine
                        </a>
                        <a href="${pageContext.request.contextPath}/inventory/bulk-import" class="btn btn-outline">
                            <i class="fas fa-upload"></i>
                            Bulk Import
                        </a>
                        <a href="${pageContext.request.contextPath}/inventory/export" class="btn btn-outline">
                            <i class="fas fa-download"></i>
                            Export Data
                        </a>
                        <a href="${pageContext.request.contextPath}/inventory/reports" class="btn btn-outline">
                            <i class="fas fa-chart-bar"></i>
                            View Reports
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Notification -->
    <div id="notification" class="notification">
        <i id="notification-icon" class="fas"></i>
        <span id="notification-message"></span>
    </div>

    <script>
        // Notification system
        function showNotification(message, type) {
            var notification = document.getElementById('notification');
            var icon = document.getElementById('notification-icon');
            var messageEl = document.getElementById('notification-message');

            notification.className = 'notification ' + type;

            var iconClass = 'fas ' + (type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle');
            icon.className = iconClass;
            messageEl.textContent = message;

            notification.classList.add('show');

            setTimeout(function() {
                notification.classList.remove('show');
            }, 4000);
        }

        // Show notifications if present
        <c:if test="${not empty success}">
            showNotification("${success}", 'success');
        </c:if>
        <c:if test="${not empty error}">
            showNotification("${error}", 'error');
        </c:if>

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // Ctrl/Cmd + K to focus search
            if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
                e.preventDefault();
                document.querySelector('.search-input').focus();
            }
        });

        // Auto-submit search after typing pause (optional)
        var searchTimeout;
        var searchInput = document.querySelector('.search-input');
        if (searchInput) {
            searchInput.addEventListener('input', function() {
                clearTimeout(searchTimeout);
                var form = this.closest('form');
                var self = this;
                searchTimeout = setTimeout(function() {
                    if (self.value.length > 2 || self.value.length === 0) {
                        form.submit();
                    }
                }, 1000); // Increased delay to 1 second
            });

            // Enter key support for search
            searchInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    this.closest('form').submit();
                }
            });
        }
    </script>
</body>
</html>
