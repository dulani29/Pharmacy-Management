<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Add New Medicine | PharmaCare Inventory</title>
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
            --background-input: #ffffff;

            --text-primary: #1a202c;
            --text-secondary: #4a5568;
            --text-muted: #718096;
            --text-disabled: #a0aec0;

            --border-light: #e2e8f0;
            --border-medium: #cbd5e0;
            --border-dark: #a0aec0;
            --border-focus: #4299e1;

            --accent-blue: #4299e1;
            --accent-teal: #38b2ac;
            --accent-slate: #64748b;
            --accent-emerald: #059669;
            --accent-rose: #e11d48;

            --success-light: #f0fff4;
            --success-medium: #68d391;
            --success-dark: #38a169;

            --error-light: #fef2f2;
            --error-medium: #fc8181;
            --error-dark: #e53e3e;

            --warning-light: #fffbeb;
            --warning-medium: #f6e05e;
            --warning-dark: #d69e2e;

            --shadow-subtle: 0 1px 3px rgba(0, 0, 0, 0.05);
            --shadow-card: 0 4px 6px rgba(0, 0, 0, 0.05);
            --shadow-elevated: 0 10px 15px rgba(0, 0, 0, 0.08);
            --shadow-focus: 0 0 0 3px rgba(66, 153, 225, 0.1);

            --radius-sm: 6px;
            --radius-md: 8px;
            --radius-lg: 12px;
            --radius-xl: 16px;
            --radius-2xl: 20px;

            --transition-fast: 0.15s ease;
            --transition-smooth: 0.3s ease;
            --transition-slow: 0.5s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: var(--background-main);
            color: var(--text-primary);
            line-height: 1.6;
            font-weight: 400;
            min-height: 100vh;
        }

        /* Header Navigation */
        .header {
            background: var(--background-card);
            border-bottom: 1px solid var(--border-light);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 100;
            backdrop-filter: blur(10px);
        }

        .header-container {
            max-width: 1200px;
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

        .nav-actions {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .btn-nav {
            padding: 0.75rem 1.25rem;
            border: 1px solid var(--border-medium);
            border-radius: var(--radius-md);
            background: var(--background-card);
            color: var(--text-secondary);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.875rem;
            transition: var(--transition-smooth);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-nav:hover {
            background: var(--background-subtle);
            border-color: var(--border-dark);
            color: var(--text-primary);
        }

        .btn-nav.danger {
            border-color: var(--error-medium);
            color: var(--error-dark);
        }

        .btn-nav.danger:hover {
            background: var(--error-light);
            border-color: var(--error-dark);
        }

        /* Main Container */
        .container {
            max-width: 900px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        /* Page Header */
        .page-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 2.25rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
        }

        .page-title i {
            color: var(--secondary-medium);
            font-size: 2rem;
        }

        .page-description {
            color: var(--text-secondary);
            font-size: 1.125rem;
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.6;
        }

        /* Form Card */
        .form-card {
            background: var(--background-card);
            border: 1px solid var(--border-light);
            border-radius: var(--radius-2xl);
            padding: 2.5rem;
            box-shadow: var(--shadow-card);
            position: relative;
            overflow: hidden;
        }

        .form-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-teal));
        }

        /* Form Grid */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-label {
            font-weight: 500;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-label .required {
            color: var(--accent-rose);
            font-size: 0.75rem;
        }

        .form-label i {
            color: var(--text-muted);
            font-size: 0.875rem;
        }

        .form-control {
            padding: 1rem;
            border: 2px solid var(--border-medium);
            border-radius: var(--radius-lg);
            font-size: 0.875rem;
            background: var(--background-input);
            transition: var(--transition-fast);
            font-weight: 400;
            color: var(--text-primary);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--border-focus);
            box-shadow: var(--shadow-focus);
        }

        .form-control:invalid {
            border-color: var(--error-medium);
        }

        .form-control:disabled,
        .form-control:read-only {
            background: var(--background-subtle);
            color: var(--text-disabled);
            cursor: not-allowed;
            border-color: var(--border-light);
        }

        .form-select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
            background-position: right 0.75rem center;
            background-repeat: no-repeat;
            background-size: 1.5em 1.5em;
            padding-right: 3rem;
        }

        .form-textarea {
            min-height: 120px;
            resize: vertical;
            font-family: inherit;
        }

        .form-note {
            font-size: 0.75rem;
            color: var(--text-muted);
            margin-top: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.375rem;
        }

        .form-note i {
            font-size: 0.75rem;
        }

        .form-note.info {
            color: var(--accent-blue);
        }

        .form-note.warning {
            color: var(--warning-dark);
        }

        /* Input Groups */
        .input-group {
            position: relative;
        }

        .input-group-text {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 0.875rem;
            pointer-events: none;
        }

        .input-group .form-control {
            padding-left: 2.5rem;
        }

        /* Button Styles */
        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: var(--radius-lg);
            font-weight: 500;
            font-size: 0.875rem;
            cursor: pointer;
            transition: var(--transition-smooth);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            text-decoration: none;
            white-space: nowrap;
            position: relative;
            overflow: hidden;
        }

        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }

        .btn-primary {
            background: var(--primary-dark);
            color: white;
            box-shadow: var(--shadow-card);
        }

        .btn-primary:hover:not(:disabled) {
            background: var(--primary-medium);
            transform: translateY(-1px);
            box-shadow: var(--shadow-elevated);
        }

        .btn-secondary {
            background: var(--secondary-medium);
            color: white;
        }

        .btn-secondary:hover:not(:disabled) {
            background: var(--secondary-dark);
            transform: translateY(-1px);
            box-shadow: var(--shadow-card);
        }

        .btn-outline {
            background: transparent;
            border: 2px solid var(--border-medium);
            color: var(--text-secondary);
        }

        .btn-outline:hover:not(:disabled) {
            background: var(--background-subtle);
            border-color: var(--border-dark);
            color: var(--text-primary);
        }

        /* Button Group */
        .button-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            flex-wrap: wrap;
        }

        /* Messages */
        .message {
            padding: 1rem 1.5rem;
            border-radius: var(--radius-lg);
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 500;
        }

        .message.success {
            background: var(--success-light);
            color: var(--success-dark);
            border: 1px solid var(--success-medium);
        }

        .message.error {
            background: var(--error-light);
            color: var(--error-dark);
            border: 1px solid var(--error-medium);
        }

        .message.warning {
            background: var(--warning-light);
            color: var(--warning-dark);
            border: 1px solid var(--warning-medium);
        }

        /* Success Modal */
        .success-modal {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(26, 32, 44, 0.8);
            backdrop-filter: blur(4px);
            z-index: 1000;
            display: none;
            align-items: center;
            justify-content: center;
            animation: fadeIn 0.3s ease;
        }

        .success-modal.show {
            display: flex;
        }

        .modal-content {
            background: var(--background-card);
            border-radius: var(--radius-2xl);
            padding: 3rem 2rem;
            max-width: 400px;
            width: 90%;
            text-align: center;
            box-shadow: var(--shadow-elevated);
            animation: slideUp 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .modal-content::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--success-medium), var(--accent-teal));
        }

        .modal-icon {
            width: 80px;
            height: 80px;
            background: var(--success-light);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            color: var(--success-dark);
            font-size: 2rem;
            animation: checkmark 0.6s ease;
        }

        .modal-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 1rem;
        }

        .modal-message {
            color: var(--text-secondary);
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }

        .countdown-container {
            background: var(--background-subtle);
            border-radius: var(--radius-lg);
            padding: 1rem;
            margin-bottom: 1rem;
        }

        .countdown {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--accent-teal);
            margin-bottom: 0.5rem;
        }

        .progress-bar {
            width: 100%;
            height: 6px;
            background: var(--border-light);
            border-radius: 3px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--accent-teal), var(--accent-blue));
            border-radius: 3px;
            animation: progressCountdown 3s linear;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from {
                transform: translateY(30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes checkmark {
            0% { transform: scale(0); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }

        @keyframes progressCountdown {
            from { width: 100%; }
            to { width: 0%; }
        }

        /* Loading State */
        .btn-loading {
            position: relative;
            color: transparent !important;
        }

        .btn-loading::after {
            content: '';
            position: absolute;
            width: 20px;
            height: 20px;
            top: 50%;
            left: 50%;
            margin-left: -10px;
            margin-top: -10px;
            border: 2px solid transparent;
            border-top-color: currentColor;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            color: white;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 0 1rem;
                margin: 1rem auto;
            }

            .header-container {
                padding: 0 1rem;
                flex-direction: column;
                gap: 1rem;
            }

            .nav-actions {
                justify-content: center;
            }

            .form-card {
                padding: 2rem 1.5rem;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .page-title {
                font-size: 1.75rem;
                flex-direction: column;
                gap: 0.5rem;
            }

            .button-group {
                flex-direction: column;
                align-items: stretch;
            }

            .btn {
                justify-content: center;
            }

            .modal-content {
                padding: 2rem 1.5rem;
                margin: 1rem;
            }
        }

        /* Focus and Accessibility */
        .form-control:focus,
        .btn:focus {
            outline: 2px solid var(--border-focus);
            outline-offset: 2px;
        }

        /* Print Styles */
        @media print {
            .header,
            .nav-actions,
            .button-group {
                display: none;
            }

            .form-card {
                box-shadow: none;
                border: 1px solid var(--border-dark);
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-container">
            <a href="${pageContext.request.contextPath}/inventory/dashboard" class="nav-brand">
                <i class="fas fa-capsules"></i>
                Inventory Manager
            </a>
            <div class="nav-actions">
                <a href="${pageContext.request.contextPath}/inventory/dashboard" class="btn-nav">
                    <i class="fas fa-arrow-left"></i>
                    Back to Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="btn-nav danger">
                    <i class="fas fa-sign-out-alt"></i>
                    Logout
                </a>
            </div>
        </div>
    </header>

    <!-- Main Container -->
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">
                <i class="fas fa-plus-circle"></i>
                Add New Medicine
            </h1>
            <p class="page-description">
                Enter the medicine details to add new stock to your pharmacy inventory.
                All required fields must be completed accurately.
            </p>
        </div>

        <!-- Messages -->
        <c:if test="${not empty success}">
            <div id="successFlag" data-success="true" style="display: none;">${success}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="message error">
                <i class="fas fa-exclamation-circle"></i>
                ${error}
            </div>
        </c:if>

        <!-- Form -->
        <div class="form-card">
            <form action="${pageContext.request.contextPath}/inventory/add-stock" method="POST" id="medicineForm">
                <div class="form-grid">
                    <!-- Medicine Name -->
                    <div class="form-group">
                        <label class="form-label" for="name">
                            <i class="fas fa-pills"></i>
                            Medicine Name
                            <span class="required">*</span>
                        </label>
                        <input type="text"
                               id="name"
                               name="name"
                               class="form-control"
                               placeholder="Enter medicine name"
                               required
                               autocomplete="off">
                        <div class="form-note">
                            <i class="fas fa-info-circle"></i>
                            Enter the complete generic or brand name
                        </div>
                    </div>

                    <!-- Medicine Type -->
                    <div class="form-group">
                        <label class="form-label" for="type">
                            <i class="fas fa-capsule"></i>
                            Medicine Type
                            <span class="required">*</span>
                        </label>
                        <select id="type" name="type" class="form-control form-select" required>
                            <option value="">Select medicine type</option>
                            <c:forEach items="${medicineTypes}" var="type">
                                <option value="${type}">${type}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Category (Hidden - Auto set) -->
                    <input type="hidden" name="category" value="Uncategorized">
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-tags"></i>
                            Medicine Category
                        </label>
                        <input type="text"
                               class="form-control"
                               value="Uncategorized"
                               readonly>
                        <div class="form-note info">
                            <i class="fas fa-info-circle"></i>
                            Category is set to "Uncategorized" by default. Pharmacists can update this later.
                        </div>
                    </div>

                    <!-- Company -->
                    <div class="form-group">
                        <label class="form-label" for="company">
                            <i class="fas fa-building"></i>
                            Manufacturing Company
                            <span class="required">*</span>
                        </label>
                        <input type="text"
                               id="company"
                               name="company"
                               class="form-control"
                               placeholder="Enter company name"
                               required
                               autocomplete="off">
                    </div>

                    <!-- Price -->
                    <div class="form-group">
                        <label class="form-label" for="price">
                            <i class="fas fa-dollar-sign"></i>
                            Unit Price (Rs.)
                            <span class="required">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">Rs.</span>
                            <input type="number"
                                   id="price"
                                   name="price"
                                   class="form-control"
                                   placeholder="0.00"
                                   step="0.01"
                                   min="0"
                                   required>
                        </div>
                    </div>

                    <!-- Quantity -->
                    <div class="form-group">
                        <label class="form-label" for="quantity">
                            <i class="fas fa-boxes"></i>
                            Initial Stock Quantity
                            <span class="required">*</span>
                        </label>
                        <input type="number"
                               id="quantity"
                               name="quantity"
                               class="form-control"
                               placeholder="Enter initial quantity"
                               min="1"
                               required>
                        <div class="form-note">
                            <i class="fas fa-info-circle"></i>
                            Number of units being added to inventory
                        </div>
                    </div>

                    <!-- Minimum Stock -->
                    <div class="form-group">
                        <label class="form-label" for="minimumStock">
                            <i class="fas fa-layer-group"></i>
                            Minimum Stock Level
                            <span class="required">*</span>
                        </label>
                        <input type="number"
                               id="minimumStock"
                               name="minimumStock"
                               class="form-control"
                               placeholder="Enter minimum stock threshold"
                               min="1"
                               value="10"
                               required>
                        <div class="form-note warning">
                            <i class="fas fa-exclamation-triangle"></i>
                            System will alert when stock falls below this level
                        </div>
                    </div>

                    <!-- Expiry Date -->
                    <div class="form-group full-width">
                        <label class="form-label" for="expiryDate">
                            <i class="fas fa-calendar-alt"></i>
                            Expiry Date
                            <span class="required">*</span>
                        </label>
                        <input type="date"
                               id="expiryDate"
                               name="expiryDate"
                               class="form-control"
                               required>
                        <div class="form-note warning">
                            <i class="fas fa-clock"></i>
                            Must be a future date. Expired medicines cannot be added.
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="form-group full-width">
                        <label class="form-label" for="description">
                            <i class="fas fa-align-left"></i>
                            Description
                            <span style="color: var(--text-muted); font-weight: 400;">(Optional)</span>
                        </label>
                        <textarea id="description"
                                  name="description"
                                  class="form-control form-textarea"
                                  placeholder="Enter additional medicine information, usage instructions, or notes..."></textarea>
                        <div class="form-note">
                            <i class="fas fa-info-circle"></i>
                            Additional information that may be helpful for pharmacists
                        </div>
                    </div>
                </div>

                <!-- Submit Buttons -->
                <div class="button-group">
                    <button type="submit" class="btn btn-primary" id="submitBtn">
                        <i class="fas fa-save"></i>
                        Add Medicine to Inventory
                    </button>
                    <a href="${pageContext.request.contextPath}/inventory/dashboard" class="btn btn-outline">
                        <i class="fas fa-times"></i>
                        Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>

    <!-- Success Modal -->
    <div id="successModal" class="success-modal">
        <div class="modal-content">
            <div class="modal-icon">
                <i class="fas fa-check"></i>
            </div>
            <h2 class="modal-title">Medicine Added Successfully!</h2>
            <p class="modal-message">
                The new medicine has been successfully added to your inventory and is now available for use.
            </p>
            <div class="countdown-container">
                <div class="countdown" id="countdown">3</div>
                <p style="color: var(--text-muted); font-size: 0.875rem; margin: 0;">
                    Redirecting to dashboard...
                </p>
                <div class="progress-bar">
                    <div class="progress-fill"></div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize form
            initializeForm();

            // Check for success message
            var successFlag = document.getElementById('successFlag');
            if (successFlag && successFlag.dataset.success === 'true') {
                showSuccessModal();
            }
        });

        function initializeForm() {
            var form = document.getElementById('medicineForm');
            var submitBtn = document.getElementById('submitBtn');
            var expiryInput = document.getElementById('expiryDate');

            // Set minimum date for expiry to tomorrow
            var tomorrow = new Date();
            tomorrow.setDate(tomorrow.getDate() + 1);
            var minDate = tomorrow.toISOString().split('T')[0];
            expiryInput.min = minDate;

            // Form validation on submit
            form.addEventListener('submit', function(e) {
                if (!validateForm()) {
                    e.preventDefault();
                    return false;
                }

                // Show loading state
                submitBtn.classList.add('btn-loading');
                submitBtn.disabled = true;

                // Re-enable after timeout (in case of error)
                setTimeout(function() {
                    submitBtn.classList.remove('btn-loading');
                    submitBtn.disabled = false;
                }, 10000);
            });

            // Real-time validation
            var inputs = form.querySelectorAll('.form-control[required]');
            inputs.forEach(function(input) {
                input.addEventListener('blur', function() {
                    validateField(this);
                });
            });
        }

        function validateForm() {
            var isValid = true;
            var form = document.getElementById('medicineForm');
            var requiredFields = form.querySelectorAll('.form-control[required]');

            requiredFields.forEach(function(field) {
                if (!validateField(field)) {
                    isValid = false;
                }
            });

            // Additional validation for expiry date
            var expiryDate = new Date(document.getElementById('expiryDate').value);
            var today = new Date();
            today.setHours(0, 0, 0, 0);

            if (expiryDate <= today) {
                showFieldError(document.getElementById('expiryDate'), 'Expiry date must be in the future');
                isValid = false;
            }

            return isValid;
        }

        function validateField(field) {
            var value = field.value.trim();
            var isValid = true;

            // Remove previous error styling
            field.style.borderColor = '';
            var existingError = field.parentNode.querySelector('.field-error');
            if (existingError) {
                existingError.remove();
            }

            // Check if required field is empty
            if (field.hasAttribute('required') && !value) {
                showFieldError(field, 'This field is required');
                isValid = false;
            }

            // Type-specific validation
            if (value && field.type === 'number') {
                var numValue = parseFloat(value);
                var min = parseFloat(field.min);

                if (numValue < min) {
                    showFieldError(field, 'Value must be at least ' + min);
                    isValid = false;
                }
            }

            return isValid;
        }

        function showFieldError(field, message) {
            field.style.borderColor = 'var(--error-medium)';

            var errorDiv = document.createElement('div');
            errorDiv.className = 'field-error';
            errorDiv.style.color = 'var(--error-dark)';
            errorDiv.style.fontSize = '0.75rem';
            errorDiv.style.marginTop = '0.25rem';
            errorDiv.innerHTML = '<i class="fas fa-exclamation-circle"></i> ' + message;

            field.parentNode.appendChild(errorDiv);
        }

        function showSuccessModal() {
            var modal = document.getElementById('successModal');
            var countdown = document.getElementById('countdown');

            modal.classList.add('show');

            var timeLeft = 3;
            var timer = setInterval(function() {
                timeLeft--;
                countdown.textContent = timeLeft;

                if (timeLeft <= 0) {
                    clearInterval(timer);
                    window.location.href = '${pageContext.request.contextPath}/inventory/dashboard';
                }
            }, 1000);

            // Allow manual close
            modal.addEventListener('click', function(e) {
                if (e.target === modal) {
                    clearInterval(timer);
                    window.location.href = '${pageContext.request.contextPath}/inventory/dashboard';
                }
            });

            // ESC key support
            document.addEventListener('keydown', function(e) {
                if (e.key === 'Escape' && modal.classList.contains('show')) {
                    clearInterval(timer);
                    window.location.href = '${pageContext.request.contextPath}/inventory/dashboard';
                }
            });
        }
    </script>
</body>
</html>
