<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Medicine Category – PharmaCare</title>
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

        /* Main Container */
        .main-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Medicine Info Card */
        .medicine-info-card {
            background: white;
            border-radius: var(--radius-2xl);
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--gray-200);
            position: relative;
            overflow: hidden;
        }

        .medicine-info-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--info-500), var(--primary-500));
        }

        .medicine-header {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .medicine-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--info-100), var(--info-200));
            border-radius: var(--radius-xl);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--info-600);
            font-size: 2rem;
            flex-shrink: 0;
        }

        .medicine-details h1 {
            font-size: 1.75rem;
            font-weight: 800;
            color: var(--gray-900);
            margin-bottom: 0.5rem;
        }

        .medicine-meta {
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

        .current-category {
            background: var(--warning-100);
            color: var(--warning-700);
            padding: 0.375rem 0.875rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            border: 1px solid var(--warning-200);
        }

        .medicine-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .info-card {
            background: var(--gray-50);
            border-radius: var(--radius-lg);
            padding: 1rem;
            text-align: center;
        }

        .info-label {
            font-size: 0.75rem;
            color: var(--gray-500);
            text-transform: uppercase;
            letter-spacing: 0.05em;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .info-value {
            font-size: 1rem;
            font-weight: 600;
            color: var(--gray-900);
        }

        .price-value {
            color: var(--primary-600);
            font-size: 1.125rem;
        }

        .stock-value {
            color: var(--success-600);
        }

        /* Update Form */
        .update-form-card {
            background: white;
            border-radius: var(--radius-2xl);
            padding: 3rem;
            box-shadow: var(--shadow-xl);
            border: 1px solid var(--gray-200);
            position: relative;
            overflow: hidden;
        }

        .update-form-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--warning-500), var(--secondary-500));
        }

        .form-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .form-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--gray-900);
            margin-bottom: 0.5rem;
        }

        .form-subtitle {
            color: var(--gray-600);
            font-size: 1rem;
        }

        /* Category Selection */
        .category-selection {
            margin-bottom: 2rem;
        }

        .section-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--gray-900);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .category-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .category-card {
            padding: 1.5rem;
            border: 2px solid var(--gray-200);
            border-radius: var(--radius-lg);
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            background: white;
            position: relative;
        }

        .category-card:hover {
            border-color: var(--primary-300);
            background: var(--primary-50);
            transform: translateY(-2px);
        }

        .category-card.selected {
            border-color: var(--primary-500);
            background: var(--primary-50);
            box-shadow: 0 0 0 3px rgb(59 130 246 / 0.1);
        }

        .category-card.current {
            border-color: var(--warning-500);
            background: var(--warning-50);
        }

        .category-icon {
            font-size: 2rem;
            margin-bottom: 1rem;
            color: var(--gray-600);
        }

        .category-card.selected .category-icon,
        .category-card:hover .category-icon {
            color: var(--primary-600);
        }

        .category-card.current .category-icon {
            color: var(--warning-600);
        }

        .category-name {
            font-weight: 600;
            color: var(--gray-900);
            margin-bottom: 0.5rem;
            text-transform: capitalize;
        }

        .category-description {
            font-size: 0.875rem;
            color: var(--gray-600);
        }

        .current-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background: var(--warning-500);
            color: white;
            padding: 0.25rem 0.5rem;
            border-radius: 9999px;
            font-size: 0.6rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        /* Custom Category Input */
        .custom-category {
            margin-top: 1rem;
            padding: 1rem;
            background: var(--gray-50);
            border-radius: var(--radius-lg);
            border: 2px dashed var(--gray-300);
        }

        .custom-category.active {
            border-color: var(--primary-500);
            background: var(--primary-50);
        }

        .custom-input {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid var(--gray-300);
            border-radius: var(--radius-md);
            font-size: 1rem;
            margin-top: 0.5rem;
            transition: all 0.3s ease;
        }

        .custom-input:focus {
            outline: none;
            border-color: var(--primary-500);
            box-shadow: 0 0 0 3px rgb(59 130 246 / 0.1);
        }

        /* Form Actions */
        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 2px solid var(--gray-100);
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
            background: linear-gradient(135deg, var(--primary-500), var(--primary-600));
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

            .update-form-card {
                padding: 2rem 1.5rem;
            }

            .medicine-info-card {
                padding: 1.5rem;
            }

            .medicine-header {
                flex-direction: column;
                text-align: center;
            }

            .category-grid {
                grid-template-columns: 1fr;
            }

            .form-actions {
                flex-direction: column;
            }
        }

        @media (max-width: 480px) {
            .header-container {
                padding: 1rem;
            }

            .medicine-grid {
                grid-template-columns: 1fr;
            }

            .medicine-icon {
                width: 60px;
                height: 60px;
                font-size: 1.5rem;
            }

            .medicine-details h1 {
                font-size: 1.5rem;
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

            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/pharmacist-dashboard">Dashboard</a>
                <i class="fas fa-chevron-right"></i>
                <a href="${pageContext.request.contextPath}/pharmacist/medicine-inventory">Inventory</a>
                <i class="fas fa-chevron-right"></i>
                <span>Update Category</span>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-container">
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

        <!-- Medicine Info Card -->
        <div class="medicine-info-card">
            <div class="medicine-header">
                <div class="medicine-icon">
                    <i class="fas fa-pills"></i>
                </div>
                <div class="medicine-details">
                    <h1>${medicine.name}</h1>
                    <div class="medicine-meta">
                        <div class="meta-item">
                            <i class="fas fa-tag"></i>
                            <span>${medicine.type}</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-building"></i>
                            <span>${medicine.company}</span>
                        </div>
                        <div class="current-category">
                            Current: ${medicine.category != null ? medicine.category : 'Uncategorized'}
                        </div>
                    </div>
                </div>
            </div>

            <div class="medicine-grid">
                <div class="info-card">
                    <div class="info-label">Price</div>
                    <div class="info-value price-value">Rs. ${medicine.price}</div>
                </div>
                <div class="info-card">
                    <div class="info-label">Stock</div>
                    <div class="info-value stock-value">${medicine.quantity} units</div>
                </div>
                <div class="info-card">
                    <div class="info-label">Minimum Stock</div>
                    <div class="info-value">${medicine.minimumStock} units</div>
                </div>
                <div class="info-card">
                    <div class="info-label">Expiry Date</div>
                    <div class="info-value">${medicine.expiryDate}</div>
                </div>
            </div>
        </div>

        <!-- Update Form -->
        <div class="update-form-card">
            <div class="form-header">
                <h2 class="form-title">Update Medicine Category</h2>
                <p class="form-subtitle">Select a new category for this medicine</p>
            </div>

            <form action="${pageContext.request.contextPath}/pharmacist/medicine-inventory/update-category" method="POST" id="updateCategoryForm">
                <input type="hidden" name="medicineId" value="${medicine.id}">
                <input type="hidden" name="category" id="selectedCategory" value="${medicine.category}">

                <div class="category-selection">
                    <h3 class="section-title">
                        <i class="fas fa-tags"></i>
                        Available Categories
                    </h3>

                    <div class="category-grid">
                        <div class="category-card ${medicine.category == 'tablet' ? 'current' : ''}" data-category="tablet">
                            <div class="category-icon">
                                <i class="fas fa-pills"></i>
                            </div>
                            <div class="category-name">Tablet</div>
                            <div class="category-description">Solid dosage form</div>
                            <c:if test="${medicine.category == 'tablet'}">
                                <div class="current-badge">Current</div>
                            </c:if>
                        </div>

                        <div class="category-card ${medicine.category == 'syrup' ? 'current' : ''}" data-category="syrup">
                            <div class="category-icon">
                                <i class="fas fa-flask"></i>
                            </div>
                            <div class="category-name">Syrup</div>
                            <div class="category-description">Liquid medication</div>
                            <c:if test="${medicine.category == 'syrup'}">
                                <div class="current-badge">Current</div>
                            </c:if>
                        </div>

                        <div class="category-card ${medicine.category == 'injection' ? 'current' : ''}" data-category="injection">
                            <div class="category-icon">
                                <i class="fas fa-syringe"></i>
                            </div>
                            <div class="category-name">Injection</div>
                            <div class="category-description">Injectable solution</div>
                            <c:if test="${medicine.category == 'injection'}">
                                <div class="current-badge">Current</div>
                            </c:if>
                        </div>

                        <div class="category-card ${medicine.category == 'capsule' ? 'current' : ''}" data-category="capsule">
                            <div class="category-icon">
                                <i class="fas fa-capsules"></i>
                            </div>
                            <div class="category-name">Capsule</div>
                            <div class="category-description">Encapsulated medication</div>
                            <c:if test="${medicine.category == 'capsule'}">
                                <div class="current-badge">Current</div>
                            </c:if>
                        </div>

                        <div class="category-card ${medicine.category == 'cream' ? 'current' : ''}" data-category="cream">
                            <div class="category-icon">
                                <i class="fas fa-hand-holding-medical"></i>
                            </div>
                            <div class="category-name">Cream</div>
                            <div class="category-description">Topical application</div>
                            <c:if test="${medicine.category == 'cream'}">
                                <div class="current-badge">Current</div>
                            </c:if>
                        </div>

                        <div class="category-card ${medicine.category == 'drops' ? 'current' : ''}" data-category="drops">
                            <div class="category-icon">
                                <i class="fas fa-eye-dropper"></i>
                            </div>
                            <div class="category-name">Drops</div>
                            <div class="category-description">Eye/ear drops</div>
                            <c:if test="${medicine.category == 'drops'}">
                                <div class="current-badge">Current</div>
                            </c:if>
                        </div>

                        <div class="category-card" data-category="custom">
                            <div class="category-icon">
                                <i class="fas fa-plus"></i>
                            </div>
                            <div class="category-name">Custom</div>
                            <div class="category-description">Create new category</div>
                        </div>
                    </div>

                    <div class="custom-category" id="customCategory" style="display: none;">
                        <label for="customCategoryInput" style="font-weight: 600; color: var(--gray-700); display: block; margin-bottom: 0.5rem;">
                            <i class="fas fa-edit"></i> Enter Custom Category
                        </label>
                        <input type="text" id="customCategoryInput" class="custom-input"
                               placeholder="Enter new category name..." maxlength="50">
                    </div>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/pharmacist/medicine-inventory" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Cancel
                    </a>
                    <button type="submit" class="btn btn-primary" id="submitBtn" disabled>
                        <span class="loading-spinner" id="loadingSpinner"></span>
                        <i class="fas fa-save" id="submitIcon"></i>
                        Update Category
                    </button>
                </div>
            </form>
        </div>
    </main>

    <!-- Scripts -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const categoryCards = document.querySelectorAll('.category-card');
            const selectedCategoryInput = document.getElementById('selectedCategory');
            const customCategory = document.getElementById('customCategory');
            const customCategoryInput = document.getElementById('customCategoryInput');
            const submitBtn = document.getElementById('submitBtn');
            const form = document.getElementById('updateCategoryForm');
            const loadingSpinner = document.getElementById('loadingSpinner');
            const submitIcon = document.getElementById('submitIcon');

            let selectedCategory = '${medicine.category}';

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

            // Category selection
            categoryCards.forEach(card => {
                card.addEventListener('click', function() {
                    const category = this.dataset.category;

                    // Remove selected class from all cards
                    categoryCards.forEach(c => c.classList.remove('selected'));

                    if (category === 'custom') {
                        this.classList.add('selected');
                        customCategory.style.display = 'block';
                        customCategory.classList.add('active');
                        customCategoryInput.focus();
                        selectedCategory = '';
                        updateSubmitButton();
                    } else {
                        this.classList.add('selected');
                        customCategory.style.display = 'none';
                        customCategory.classList.remove('active');
                        selectedCategory = category;
                        selectedCategoryInput.value = category;
                        updateSubmitButton();
                    }
                });
            });

            // Custom category input
            customCategoryInput.addEventListener('input', function() {
                selectedCategory = this.value.trim();
                selectedCategoryInput.value = selectedCategory;
                updateSubmitButton();
            });

            function updateSubmitButton() {
                const currentCategory = '${medicine.category}';
                const hasChanged = selectedCategory !== currentCategory;
                const isValid = selectedCategory && selectedCategory.length > 0;

                submitBtn.disabled = !hasChanged || !isValid;

                if (hasChanged && isValid) {
                    submitBtn.classList.remove('opacity-60');
                } else {
                    submitBtn.classList.add('opacity-60');
                }
            }

            // Form submission
            form.addEventListener('submit', function(e) {
                if (!selectedCategory || selectedCategory.trim() === '') {
                    e.preventDefault();
                    alert('Please select a category.');
                    return;
                }

                submitBtn.disabled = true;
                loadingSpinner.style.display = 'inline-block';
                submitIcon.style.display = 'none';
                submitBtn.innerHTML = '<span class="loading-spinner" style="display: inline-block;"></span> Updating...';
            });

            // Initialize with current category
            const currentCategoryCard = document.querySelector(`[data-category="${selectedCategory}"]`);
            if (currentCategoryCard && !currentCategoryCard.classList.contains('current')) {
                currentCategoryCard.classList.add('selected');
            }

            updateSubmitButton();
        });
    </script>
</body>
</html>
