<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medicine Inventory – PharmaCare</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-500: #3b82f6;
            --primary-600: #2563eb;
            --primary-700: #1d4ed8;
            --primary-50: #eff6ff;
            --primary-100: #dbeafe;

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

        /* Header */
        .header {
            background: white;
            border-bottom: 1px solid var(--gray-200);
            box-shadow: var(--shadow-sm);
            position: sticky;
            top: 0;
            z-index: 50;
        }

        .header-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .brand {
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

        .nav-links {
            display: flex;
            gap: 2rem;
            align-items: center;
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

        /* Main Container */
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
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-500), var(--secondary-500));
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

        /* Controls Bar */
        .controls-bar {
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
            box-shadow: 0 0 0 3px rgb(59 130 246 / 0.1);
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
            min-width: 150px;
        }

        .filter-dropdown:hover {
            border-color: var(--primary-300);
        }

        /* View Toggle */
        .view-toggle {
            display: flex;
            background: var(--gray-100);
            border-radius: var(--radius-lg);
            padding: 0.25rem;
        }

        .view-btn {
            padding: 0.5rem 1rem;
            border: none;
            background: transparent;
            color: var(--gray-600);
            border-radius: var(--radius-md);
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .view-btn.active {
            background: white;
            color: var(--primary-600);
            box-shadow: var(--shadow-sm);
        }

        /* Category Tabs */
        .category-tabs {
            background: white;
            border-radius: var(--radius-xl);
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--gray-200);
        }

        .tabs-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .tabs-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--gray-900);
        }

        .tabs-container {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .tab-btn {
            padding: 0.75rem 1.5rem;
            border: 2px solid var(--gray-200);
            background: white;
            color: var(--gray-700);
            border-radius: var(--radius-lg);
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .tab-btn:hover {
            border-color: var(--primary-300);
            background: var(--primary-50);
        }

        .tab-btn.active {
            border-color: var(--primary-500);
            background: var(--primary-50);
            color: var(--primary-700);
        }

        .tab-count {
            background: var(--gray-200);
            color: var(--gray-700);
            padding: 0.25rem 0.5rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .tab-btn.active .tab-count {
            background: var(--primary-200);
            color: var(--primary-800);
        }

        /* Medicine Grid */
        .medicine-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 1.5rem;
        }

        .medicine-card {
            background: white;
            border-radius: var(--radius-xl);
            border: 2px solid var(--gray-200);
            overflow: hidden;
            transition: all 0.3s ease;
            position: relative;
        }

        .medicine-card:hover {
            border-color: var(--primary-300);
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .card-header {
            padding: 1.5rem 1.5rem 1rem;
            border-bottom: 1px solid var(--gray-100);
        }

        .medicine-name {
            font-size: 1.125rem;
            font-weight: 700;
            color: var(--gray-900);
            margin-bottom: 0.5rem;
        }

        .medicine-type {
            font-size: 0.875rem;
            color: var(--gray-500);
            margin-bottom: 0.75rem;
        }

        .medicine-company {
            font-size: 0.875rem;
            font-weight: 500;
            color: var(--gray-700);
        }

        .card-body {
            padding: 1rem 1.5rem;
        }

        .medicine-info {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .info-item {
            display: flex;
            flex-direction: column;
        }

        .info-label {
            font-size: 0.75rem;
            color: var(--gray-500);
            text-transform: uppercase;
            letter-spacing: 0.05em;
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .info-value {
            font-size: 0.875rem;
            font-weight: 600;
            color: var(--gray-900);
        }

        .price-tag {
            color: var(--primary-600);
            font-size: 1rem;
        }

        .stock-badge {
            padding: 0.375rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .stock-high {
            background: var(--success-100);
            color: var(--success-700);
            border: 1px solid var(--success-200);
        }

        .stock-medium {
            background: var(--warning-100);
            color: var(--warning-700);
            border: 1px solid var(--warning-200);
        }

        .stock-low {
            background: var(--danger-100);
            color: var(--danger-700);
            border: 1px solid var(--danger-200);
        }

        .expiry-badge {
            padding: 0.375rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .expiry-good {
            background: var(--success-100);
            color: var(--success-700);
        }

        .expiry-warning {
            background: var(--warning-100);
            color: var(--warning-700);
        }

        .expiry-critical {
            background: var(--danger-100);
            color: var(--danger-700);
        }

        .card-actions {
            padding: 1rem 1.5rem 1.5rem;
            display: flex;
            gap: 0.5rem;
            justify-content: space-between;
        }

        .btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: var(--radius-md);
            font-weight: 500;
            font-size: 0.875rem;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-500), var(--primary-600));
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-1px);
            box-shadow: var(--shadow-md);
        }

        .btn-secondary {
            background: var(--gray-100);
            color: var(--gray-700);
            border: 1px solid var(--gray-300);
        }

        .btn-secondary:hover {
            background: var(--gray-200);
        }

        /* Medicine Table */
        .medicine-table {
            background: white;
            border-radius: var(--radius-xl);
            overflow: hidden;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--gray-200);
        }

        .table-header {
            background: var(--gray-50);
            padding: 1.5rem;
            border-bottom: 1px solid var(--gray-200);
        }

        .table-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--gray-900);
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table thead {
            background: linear-gradient(135deg, var(--gray-700), var(--gray-800));
        }

        .data-table th {
            padding: 1rem 1.5rem;
            text-align: left;
            font-weight: 600;
            color: white;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .data-table tbody tr {
            transition: all 0.2s ease;
            border-bottom: 1px solid var(--gray-100);
        }

        .data-table tbody tr:hover {
            background: var(--gray-50);
        }

        .data-table td {
            padding: 1rem 1.5rem;
            font-weight: 500;
            color: var(--gray-700);
            vertical-align: middle;
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

        /* Responsive Design */
        @media (max-width: 1024px) {
            .main-container {
                padding: 1rem;
            }

            .header-content {
                flex-direction: column;
                align-items: flex-start;
            }

            .header-stats {
                width: 100%;
                justify-content: space-between;
            }

            .medicine-grid {
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            }
        }

        @media (max-width: 768px) {
            .header-container {
                padding: 1rem;
            }

            .nav-links {
                display: none;
            }

            .controls-bar {
                flex-direction: column;
                align-items: stretch;
            }

            .search-filters {
                flex-direction: column;
            }

            .tabs-container {
                justify-content: center;
            }

            .medicine-grid {
                grid-template-columns: 1fr;
            }

            .medicine-info {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>
    <!-- Header -->
    <header class="header">
        <div class="header-container">
            <a href="${pageContext.request.contextPath}/pharmacist-dashboard" class="brand">
                <div class="brand-icon">
                    <i class="fas fa-pills"></i>
                </div>
                PharmaCare
            </a>

            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/pharmacist-dashboard" class="nav-link">
                    <i class="fas fa-home"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/pharmacist/new-prescription" class="nav-link">
                    <i class="fas fa-prescription-bottle-medical"></i> New Prescription
                </a>
                <a href="${pageContext.request.contextPath}/pharmacist/medicine-inventory" class="nav-link active">
                    <i class="fas fa-warehouse"></i> Inventory
                </a>
                <a href="${pageContext.request.contextPath}/pharmacist/prescriptions" class="nav-link">
                    <i class="fas fa-list"></i> Prescriptions
                </a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-container">
        <!-- Page Header -->
        <div class="page-header">
            <div class="header-content">
                <div class="header-info">
                    <h1>
                        <i class="fas fa-warehouse"></i>
                        Medicine Inventory
                    </h1>
                    <p>Manage and categorize medicine stock levels</p>
                </div>
                <div class="header-stats">
                    <div class="stat-item">
                        <div class="stat-number" id="totalMedicines">0</div>
                        <div class="stat-label">Total Medicines</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number" id="lowStockCount">0</div>
                        <div class="stat-label">Low Stock</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number" id="expiringSoonCount">0</div>
                        <div class="stat-label">Expiring Soon</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Controls Bar -->
        <div class="controls-bar">
            <div class="search-filters">
                <div class="search-box">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" class="search-input" placeholder="Search medicines by name, company, or type..." id="searchInput">
                </div>
                <select class="filter-dropdown" id="typeFilter">
                    <option value="">All Types</option>
                    <c:forEach items="${medicineTypes}" var="type">
                        <option value="${type}">${type}</option>
                    </c:forEach>
                </select>
                <select class="filter-dropdown" id="stockFilter">
                    <option value="">All Stock Levels</option>
                    <option value="high">High Stock</option>
                    <option value="medium">Medium Stock</option>
                    <option value="low">Low Stock</option>
                    <option value="out">Out of Stock</option>
                </select>
            </div>
            <div class="view-toggle">
                <button class="view-btn active" data-view="grid">
                    <i class="fas fa-th"></i> Grid
                </button>
                <button class="view-btn" data-view="table">
                    <i class="fas fa-list"></i> Table
                </button>
            </div>
        </div>

        <!-- Category Tabs -->
        <div class="category-tabs">
            <div class="tabs-header">
                <h3 class="tabs-title">Medicine Categories</h3>
            </div>
            <div class="tabs-container">
                <button class="tab-btn active" data-category="all">
                    <i class="fas fa-globe"></i>
                    All Categories
                    <span class="tab-count" id="allCount">0</span>
                </button>
                <c:forEach items="${categories}" var="category">
                    <button class="tab-btn" data-category="${category.key}">
                        <i class="fas fa-${category.key == 'tablet' ? 'pills' :
                                         category.key == 'syrup' ? 'flask' :
                                         category.key == 'injection' ? 'syringe' :
                                         category.key == 'capsule' ? 'capsules' :
                                         category.key == 'cream' ? 'hand-holding-medical' :
                                         category.key == 'drops' ? 'eye-dropper' : 'pills'}"></i>
                        ${category.key}
                        <span class="tab-count">${category.value}</span>
                    </button>
                </c:forEach>
            </div>
        </div>

        <!-- Medicine Content -->
        <div id="medicineContent">
            <!-- Grid View -->
            <div class="medicine-grid" id="gridView">
                <c:forEach items="${medicines}" var="medicine">
                    <div class="medicine-card"
                         data-category="${medicine.category}"
                         data-type="${medicine.type}"
                         data-stock-level="${medicine.quantity <= medicine.minimumStock ? 'low' : (medicine.quantity <= medicine.minimumStock * 2 ? 'medium' : 'high')}">

                        <div class="card-header">
                            <h3 class="medicine-name">${medicine.name}</h3>
                            <div class="medicine-type">${medicine.type}</div>
                            <div class="medicine-company">
                                <i class="fas fa-building"></i> ${medicine.company}
                            </div>
                        </div>

                        <div class="card-body">
                            <div class="medicine-info">
                                <div class="info-item">
                                    <span class="info-label">Price</span>
                                    <span class="info-value price-tag">Rs. ${medicine.price}</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Stock Level</span>
                                    <span class="stock-badge ${medicine.quantity <= 0 ? 'stock-low' :
                                                              medicine.quantity <= medicine.minimumStock ? 'stock-low' :
                                                              medicine.quantity <= medicine.minimumStock * 2 ? 'stock-medium' : 'stock-high'}">
                                        ${medicine.quantity} units
                                    </span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Expiry Date</span>
                                    <span class="expiry-badge expiry-good">${medicine.expiryDate}</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">Category</span>
                                    <span class="info-value">${medicine.category}</span>
                                </div>
                            </div>
                        </div>

                        <div class="card-actions">
                            <button class="btn btn-primary" onclick="updateCategory(${medicine.id})">
                                <i class="fas fa-edit"></i> Update Category
                            </button>
                            <button class="btn btn-secondary" onclick="viewDetails(${medicine.id})">
                                <i class="fas fa-eye"></i> View Details
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Table View -->
            <div class="medicine-table" id="tableView" style="display: none;">
                <div class="table-header">
                    <h3 class="table-title">Medicine Inventory</h3>
                </div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Medicine</th>
                            <th>Type</th>
                            <th>Company</th>
                            <th>Category</th>
                            <th>Stock</th>
                            <th>Price</th>
                            <th>Expiry</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${medicines}" var="medicine">
                            <tr data-category="${medicine.category}"
                                data-type="${medicine.type}"
                                data-stock-level="${medicine.quantity <= medicine.minimumStock ? 'low' : (medicine.quantity <= medicine.minimumStock * 2 ? 'medium' : 'high')}">
                                <td>
                                    <div>
                                        <div style="font-weight: 600; color: var(--gray-900);">${medicine.name}</div>
                                        <div style="font-size: 0.875rem; color: var(--gray-500);">ID: ${medicine.id}</div>
                                    </div>
                                </td>
                                <td>${medicine.type}</td>
                                <td>${medicine.company}</td>
                                <td>
                                    <span style="text-transform: capitalize; font-weight: 600;">${medicine.category}</span>
                                </td>
                                <td>
                                    <span class="stock-badge ${medicine.quantity <= 0 ? 'stock-low' :
                                                              medicine.quantity <= medicine.minimumStock ? 'stock-low' :
                                                              medicine.quantity <= medicine.minimumStock * 2 ? 'stock-medium' : 'stock-high'}">
                                        ${medicine.quantity} units
                                    </span>
                                </td>
                                <td>Rs. ${medicine.price}</td>
                                <td>${medicine.expiryDate}</td>
                                <td>
                                    <div style="display: flex; gap: 0.5rem;">
                                        <button class="btn btn-primary" onclick="updateCategory(${medicine.id})" style="padding: 0.375rem 0.75rem; font-size: 0.75rem;">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-secondary" onclick="viewDetails(${medicine.id})" style="padding: 0.375rem 0.75rem; font-size: 0.75rem;">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Empty State -->
            <div class="empty-state" id="emptyState" style="display: none;">
                <div class="empty-icon">
                    <i class="fas fa-search"></i>
                </div>
                <h3>No medicines found</h3>
                <p>Try adjusting your search or filter criteria</p>
            </div>
        </div>
    </main>

    <!-- Scripts -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('searchInput');
            const typeFilter = document.getElementById('typeFilter');
            const stockFilter = document.getElementById('stockFilter');
            const viewBtns = document.querySelectorAll('.view-btn');
            const tabBtns = document.querySelectorAll('.tab-btn');
            const gridView = document.getElementById('gridView');
            const tableView = document.getElementById('tableView');
            const emptyState = document.getElementById('emptyState');

            let currentCategory = 'all';
            let currentView = 'grid';

            // Initialize
            updateStats();

            // View toggle
            viewBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    viewBtns.forEach(b => b.classList.remove('active'));
                    this.classList.add('active');

                    currentView = this.dataset.view;
                    if (currentView === 'grid') {
                        gridView.style.display = 'grid';
                        tableView.style.display = 'none';
                    } else {
                        gridView.style.display = 'none';
                        tableView.style.display = 'block';
                    }
                });
            });

            // Category tabs
            tabBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    tabBtns.forEach(b => b.classList.remove('active'));
                    this.classList.add('active');

                    currentCategory = this.dataset.category;
                    filterMedicines();
                });
            });

            // Search and filters
            searchInput.addEventListener('input', filterMedicines);
            typeFilter.addEventListener('change', filterMedicines);
            stockFilter.addEventListener('change', filterMedicines);

            function filterMedicines() {
                const searchTerm = searchInput.value.toLowerCase();
                const typeValue = typeFilter.value.toLowerCase();
                const stockValue = stockFilter.value;

                const gridCards = document.querySelectorAll('.medicine-card');
                const tableRows = document.querySelectorAll('.data-table tbody tr');

                let visibleCount = 0;

                // Filter grid cards
                gridCards.forEach(card => {
                    const name = card.querySelector('.medicine-name').textContent.toLowerCase();
                    const company = card.querySelector('.medicine-company').textContent.toLowerCase();
                    const type = card.dataset.type.toLowerCase();
                    const category = card.dataset.category.toLowerCase();
                    const stockLevel = card.dataset.stockLevel;

                    const matchesSearch = !searchTerm || name.includes(searchTerm) || company.includes(searchTerm) || type.includes(searchTerm);
                    const matchesType = !typeValue || type.includes(typeValue);
                    const matchesStock = !stockValue || stockLevel === stockValue;
                    const matchesCategory = currentCategory === 'all' || category === currentCategory;

                    if (matchesSearch && matchesType && matchesStock && matchesCategory) {
                        card.style.display = 'block';
                        visibleCount++;
                    } else {
                        card.style.display = 'none';
                    }
                });

                // Filter table rows
                tableRows.forEach(row => {
                    const name = row.cells[0].textContent.toLowerCase();
                    const type = row.dataset.type.toLowerCase();
                    const category = row.dataset.category.toLowerCase();
                    const stockLevel = row.dataset.stockLevel;

                    const matchesSearch = !searchTerm || name.includes(searchTerm) || row.cells[2].textContent.toLowerCase().includes(searchTerm);
                    const matchesType = !typeValue || type.includes(typeValue);
                    const matchesStock = !stockValue || stockLevel === stockValue;
                    const matchesCategory = currentCategory === 'all' || category === currentCategory;

                    if (matchesSearch && matchesType && matchesStock && matchesCategory) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });

                // Show/hide empty state
                if (visibleCount === 0) {
                    emptyState.style.display = 'block';
                    gridView.style.display = 'none';
                    tableView.style.display = 'none';
                } else {
                    emptyState.style.display = 'none';
                    if (currentView === 'grid') {
                        gridView.style.display = 'grid';
                        tableView.style.display = 'none';
                    } else {
                        gridView.style.display = 'none';
                        tableView.style.display = 'block';
                    }
                }
            }

            function updateStats() {
                const cards = document.querySelectorAll('.medicine-card');
                let totalMedicines = cards.length;
                let lowStockCount = 0;
                let expiringSoonCount = 0;

                cards.forEach(card => {
                    if (card.dataset.stockLevel === 'low') {
                        lowStockCount++;
                    }
                    // Add expiry logic here based on your requirements
                });

                document.getElementById('totalMedicines').textContent = totalMedicines;
                document.getElementById('lowStockCount').textContent = lowStockCount;
                document.getElementById('expiringSoonCount').textContent = expiringSoonCount;
                document.getElementById('allCount').textContent = totalMedicines;
            }
        });

        function updateCategory(medicineId) {
            // This will be implemented in the controller
            window.location.href = '${pageContext.request.contextPath}/pharmacist/medicine-inventory/update-category/' + medicineId;
        }

        function viewDetails(medicineId) {
            // This will be implemented in the controller
            window.location.href = '${pageContext.request.contextPath}/pharmacist/medicine-inventory/details/' + medicineId;
        }
    </script>
</body>
</html>
