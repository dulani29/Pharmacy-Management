<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Offers & Price Management – PharmaCare Admin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-500: #6366f1;
            --primary-600: #5b21b6;
            --primary-50: #f0f9ff;
            --secondary-500: #10b981;
            --secondary-600: #059669;
            --gray-50: #f9fafb;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --gray-300: #d1d5db;
            --gray-500: #6b7280;
            --gray-600: #4b5563;
            --gray-700: #374151;
            --gray-900: #111827;
            --success-50: #f0fdf4;
            --success-500: #22c55e;
            --warning-50: #fffbeb;
            --warning-500: #f59e0b;
            --danger-50: #fef2f2;
            --danger-500: #ef4444;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1);
            --radius-md: 8px;
            --radius-lg: 12px;
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

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Header */
        .page-header {
            background: white;
            border-radius: var(--radius-lg);
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--gray-200);
        }

        .header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .page-title {
            font-size: 2rem;
            font-weight: 800;
            color: var(--gray-900);
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .title-icon {
            width: 48px;
            height: 48px;
            background: linear-gradient(135deg, var(--primary-500), var(--primary-600));
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
        }

        .back-btn {
            background: var(--gray-100);
            color: var(--gray-700);
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: var(--radius-md);
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s;
        }

        .back-btn:hover {
            background: var(--gray-200);
        }

        /* Statistics Cards */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--gray-200);
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            color: white;
        }

        .stat-icon.medicines { background: linear-gradient(135deg, var(--primary-500), var(--primary-600)); }
        .stat-icon.low-stock { background: linear-gradient(135deg, var(--warning-500), #d97706); }
        .stat-icon.expiring { background: linear-gradient(135deg, var(--danger-500), #dc2626); }

        .stat-content h3 {
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
        }

        .stat-content p {
            font-size: 0.875rem;
            color: var(--gray-600);
        }

        /* Filters and Controls */
        .controls-section {
            background: white;
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--gray-200);
        }

        .filters-row {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr auto;
            gap: 1rem;
            align-items: end;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-label {
            font-weight: 500;
            color: var(--gray-700);
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
        }

        .form-input, .form-select {
            padding: 0.75rem;
            border: 1px solid var(--gray-300);
            border-radius: var(--radius-md);
            font-size: 1rem;
            transition: all 0.3s;
        }

        .form-input:focus, .form-select:focus {
            outline: none;
            border-color: var(--primary-500);
            box-shadow: 0 0 0 3px rgb(99 102 241 / 0.1);
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: var(--radius-md);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
        }

        .btn-primary {
            background: var(--primary-500);
            color: white;
        }

        .btn-primary:hover {
            background: var(--primary-600);
        }

        .btn-secondary {
            background: var(--gray-100);
            color: var(--gray-700);
        }

        .btn-secondary:hover {
            background: var(--gray-200);
        }

        /* Medicines Table */
        .medicines-section {
            background: white;
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-md);
            border: 1px solid var(--gray-200);
            overflow: hidden;
        }

        .section-header {
            padding: 1.5rem;
            border-bottom: 1px solid var(--gray-200);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--gray-900);
        }

        .table-container {
            overflow-x: auto;
        }

        .medicines-table {
            width: 100%;
            border-collapse: collapse;
        }

        .medicines-table th {
            background: var(--gray-50);
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            color: var(--gray-700);
            border-bottom: 1px solid var(--gray-200);
            font-size: 0.875rem;
            white-space: nowrap;
        }

        .medicines-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--gray-100);
            vertical-align: middle;
        }

        .medicines-table tr:hover {
            background: var(--gray-50);
        }

        .medicine-name {
            font-weight: 600;
            color: var(--gray-900);
        }

        .medicine-details {
            font-size: 0.875rem;
            color: var(--gray-600);
            margin-top: 0.25rem;
        }

        .price-input {
            width: 100px;
            padding: 0.5rem;
            border: 1px solid var(--gray-300);
            border-radius: var(--radius-md);
            text-align: center;
            font-weight: 500;
        }

        .price-input:focus {
            outline: none;
            border-color: var(--primary-500);
            box-shadow: 0 0 0 2px rgb(99 102 241 / 0.1);
        }

        .stock-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .stock-high { background: var(--success-50); color: var(--success-500); }
        .stock-medium { background: var(--warning-50); color: var(--warning-500); }
        .stock-low { background: var(--danger-50); color: var(--danger-500); }

        .update-btn {
            padding: 0.5rem 1rem;
            background: var(--primary-500);
            color: white;
            border: none;
            border-radius: var(--radius-md);
            font-size: 0.875rem;
            cursor: pointer;
            transition: all 0.3s;
        }

        .update-btn:hover {
            background: var(--primary-600);
        }

        .update-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
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
            border: 1px solid var(--success-500);
            color: var(--success-500);
        }

        .alert.error {
            background: var(--danger-50);
            border: 1px solid var(--danger-500);
            color: var(--danger-500);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: var(--gray-500);
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: var(--gray-300);
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .filters-row {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .header-top {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .stats-row {
                grid-template-columns: 1fr;
            }

            .medicines-table {
                font-size: 0.875rem;
            }

            .medicines-table th,
            .medicines-table td {
                padding: 0.75rem 0.5rem;
            }
        }
    </style>
</head>

<body>
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <div class="header-top">
                <h1 class="page-title">
                    <div class="title-icon">
                        <i class="fas fa-tags"></i>
                    </div>
                    Offers & Price Management
                </h1>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="back-btn">
                    <i class="fas fa-arrow-left"></i>
                    Back to Dashboard
                </a>
            </div>
            <p style="color: var(--gray-600); font-size: 1rem;">
                Manage medicine prices, create offers, and monitor inventory levels
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

        <!-- Statistics -->
        <div class="stats-row">
            <div class="stat-card">
                <div class="stat-icon medicines">
                    <i class="fas fa-pills"></i>
                </div>
                <div class="stat-content">
                    <h3>${totalMedicines}</h3>
                    <p>Total Medicines</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon low-stock">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <div class="stat-content">
                    <h3>${lowStockCount}</h3>
                    <p>Low Stock Items</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon expiring">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-content">
                    <h3>${expiringSoonCount}</h3>
                    <p>Expiring Soon</p>
                </div>
            </div>
        </div>

        <!-- Filters and Controls -->
        <div class="controls-section">
            <form method="get" action="${pageContext.request.contextPath}/admin/offers">
                <div class="filters-row">
                    <div class="form-group">
                        <label class="form-label">Search Medicines</label>
                        <input type="text" name="search" class="form-input"
                               placeholder="Search by name, company, or type..."
                               value="${search}">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Category</label>
                        <select name="category" class="form-select">
                            <option value="">All Categories</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat}" ${cat eq category ? 'selected' : ''}>${cat}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Sort By</label>
                        <select name="sortBy" class="form-select">
                            <option value="">Default</option>
                            <option value="name" ${sortBy eq 'name' ? 'selected' : ''}>Name A-Z</option>
                            <option value="price_low" ${sortBy eq 'price_low' ? 'selected' : ''}>Price: Low to High</option>
                            <option value="price_high" ${sortBy eq 'price_high' ? 'selected' : ''}>Price: High to Low</option>
                            <option value="stock_low" ${sortBy eq 'stock_low' ? 'selected' : ''}>Stock: Low to High</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-search"></i>
                        Filter
                    </button>
                </div>
            </form>
        </div>

        <!-- Medicines Table -->
        <div class="medicines-section">
            <div class="section-header">
                <h2 class="section-title">
                    Medicine Inventory (${medicines.size()} items)
                </h2>
            </div>

            <c:choose>
                <c:when test="${not empty medicines}">
                    <div class="table-container">
                        <table class="medicines-table">
                            <thead>
                                <tr>
                                    <th>Medicine</th>
                                    <th>Category</th>
                                    <th>Current Price</th>
                                    <th>New Price</th>
                                    <th>Stock</th>
                                    <th>Expiry Date</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="medicine" items="${medicines}">
                                    <tr>
                                        <td>
                                            <div class="medicine-name">${medicine.name}</div>
                                            <div class="medicine-details">
                                                <c:if test="${not empty medicine.type}">${medicine.type}</c:if>
                                                <c:if test="${not empty medicine.type && not empty medicine.company}"> • </c:if>
                                                <c:if test="${not empty medicine.company}">${medicine.company}</c:if>
                                            </div>
                                        </td>
                                        <td>
                                            <span style="text-transform: capitalize;">
                                                <c:choose>
                                                    <c:when test="${not empty medicine.category}">
                                                        ${medicine.category}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Uncategorized
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td>
                                            <strong>Rs. <fmt:formatNumber value="${medicine.price}" pattern="#,##0.00"/></strong>
                                        </td>
                                        <td>
                                            <form method="post" action="${pageContext.request.contextPath}/admin/update-medicine-price"
                                                  style="display: flex; gap: 0.5rem; align-items: center;">
                                                <input type="hidden" name="medicineId" value="${medicine.id}">
                                                <input type="number" name="newPrice" class="price-input"
                                                       step="0.01" min="0.01" value="${medicine.price}"
                                                       id="price-${medicine.id}">
                                                <button type="submit" class="update-btn"
                                                        onclick="return confirmPriceUpdate('${medicine.name}', this.form)">
                                                    <i class="fas fa-save"></i>
                                                </button>
                                            </form>
                                        </td>
                                        <td>
                                            <c:set var="qty" value="${medicine.quantity}" />
                                            <c:set var="stockClass" value="${qty == 0 ? 'stock-low' : (qty < 10 ? 'stock-medium' : 'stock-high')}" />
                                            <span class="stock-badge ${stockClass}">
                                                ${qty} units
                                            </span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${medicine.expiryDate != null}">
                                                    ${medicine.expiryDate}
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: var(--gray-500);">Not specified</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-secondary"
                                                    onclick="showPriceHistory(${medicine.id}, '${medicine.name}')"
                                                    style="padding: 0.5rem; font-size: 0.75rem;">
                                                <i class="fas fa-history"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-pills"></i>
                        <h3>No medicines found</h3>
                        <p>Try adjusting your search criteria or filters</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        function confirmPriceUpdate(medicineName, form) {
            const newPriceInput = form.querySelector('input[name="newPrice"]');
            const newPrice = parseFloat(newPriceInput.value);

            if (newPrice <= 0) {
                alert('Please enter a valid price greater than 0');
                return false;
            }

            const message = `Are you sure you want to update the price of "${medicineName}" to Rs. ${newPrice.toFixed(2)}?`;
            return confirm(message);
        }

        function showPriceHistory(medicineId, medicineName) {
            alert(`Price history for ${medicineName} (ID: ${medicineId})`);

            // Example: Fetch price history via AJAX
            fetch(`${pageContext.request.contextPath}/admin/price-history/${medicineId}`)
                .then(response => response.json())
                .then(data => {
                    console.log('Price history:', data);
                    // Display in modal or alert
                })
                .catch(error => {
                    console.error('Error fetching price history:', error);
                });
        }

        // Auto-submit form when filters change
        document.addEventListener('DOMContentLoaded', function() {
            const categorySelect = document.querySelector('select[name="category"]');
            const sortSelect = document.querySelector('select[name="sortBy"]');

            [categorySelect, sortSelect].forEach(select => {
                if (select) {
                    select.addEventListener('change', function() {
                        this.form.submit();
                    });
                }
            });
        });
    </script>
</body>
</html>
