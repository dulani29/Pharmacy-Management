<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cashier Dashboard – PharmaCare</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-500: #059669;
            --primary-600: #047857;
            --primary-700: #065f46;
            --primary-50: #ecfdf5;
            --primary-100: #d1fae5;

            --secondary-500: #3b82f6;
            --secondary-600: #2563eb;
            --secondary-700: #1d4ed8;
            --secondary-50: #eff6ff;
            --secondary-100: #dbeafe;

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
            --danger-700: #b91c1c;

            --gold-500: #fbbf24;
            --gold-600: #f59e0b;
            --gold-700: #d97706;
            --gold-50: #fffbeb;
            --gold-100: #fef3c7;

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

        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
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

        .logout-btn {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.25rem;
            background: linear-gradient(135deg, var(--danger-500), var(--danger-600));
            color: white;
            border: none;
            border-radius: var(--radius-lg);
            font-weight: 600;
            font-size: 0.875rem;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-sm);
            text-decoration: none;
        }

        .logout-btn:hover {
            background: linear-gradient(135deg, var(--danger-600), var(--danger-700));
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        /* Main Container */
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 2rem;
        }

        /* Left Panel */
        .left-panel {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        /* Page Header */
        .page-header {
            background: white;
            border-radius: var(--radius-2xl);
            padding: 2rem;
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
            text-align: center;
        }

        .page-title {
            font-size: 2rem;
            font-weight: 800;
            color: var(--gray-900);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
        }

        .page-subtitle {
            color: var(--gray-600);
            font-size: 1.125rem;
        }

        /* Search Section */
        .search-section {
            background: white;
            border-radius: var(--radius-xl);
            padding: 2rem;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--gray-200);
        }

        .search-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--gray-900);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .search-form {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .search-input-container {
            flex: 1;
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 1rem 1.5rem 1rem 3rem;
            border: 2px solid var(--gray-300);
            border-radius: var(--radius-lg);
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary-500);
            box-shadow: 0 0 0 3px rgb(5 150 105 / 0.1);
        }

        .search-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray-400);
            font-size: 1.125rem;
        }

        .search-btn {
            padding: 1rem 2rem;
            background: linear-gradient(135deg, var(--primary-500), var(--primary-600));
            color: white;
            border: none;
            border-radius: var(--radius-lg);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            white-space: nowrap;
        }

        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        /* Patient Results */
        .patients-list {
            max-height: 400px;
            overflow-y: auto;
        }

        .patient-card {
            background: var(--gray-50);
            border: 2px solid var(--gray-200);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }

        .patient-card:hover {
            border-color: var(--primary-300);
            background: var(--primary-50);
            transform: translateY(-2px);
        }

        .patient-card.selected {
            border-color: var(--primary-500);
            background: var(--primary-50);
            box-shadow: 0 0 0 3px rgb(5 150 105 / 0.1);
        }

        .patient-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1rem;
        }

        .patient-info h3 {
            font-size: 1.125rem;
            font-weight: 700;
            color: var(--gray-900);
            margin-bottom: 0.25rem;
        }

        .patient-phone {
            font-size: 0.875rem;
            color: var(--gray-600);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .premium-badge {
            background: linear-gradient(135deg, var(--gold-500), var(--gold-600));
            color: white;
            padding: 0.375rem 0.875rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            display: flex;
            align-items: center;
            gap: 0.375rem;
        }

        .patient-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1rem;
            background: white;
            padding: 1rem;
            border-radius: var(--radius-md);
            border: 1px solid var(--gray-200);
        }

        .detail-item {
            text-align: center;
        }

        .detail-label {
            font-size: 0.75rem;
            color: var(--gray-500);
            text-transform: uppercase;
            letter-spacing: 0.05em;
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .detail-value {
            font-size: 1rem;
            font-weight: 600;
            color: var(--gray-900);
        }

        .points-value {
            color: var(--gold-600);
        }

        /* Billing Panel */
        .billing-panel {
            position: sticky;
            top: 100px;
            height: fit-content;
        }

        .billing-card {
            background: white;
            border-radius: var(--radius-2xl);
            box-shadow: var(--shadow-xl);
            border: 1px solid var(--gray-200);
            overflow: hidden;
            position: relative;
        }

        .billing-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--secondary-500), var(--primary-500));
        }

        .billing-header {
            background: var(--gray-50);
            padding: 1.5rem 2rem;
            border-bottom: 2px solid var(--gray-200);
        }

        .billing-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--gray-900);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .billing-body {
            padding: 2rem;
        }

        /* Selected Patient Display */
        .selected-patient {
            background: var(--primary-50);
            border: 2px solid var(--primary-200);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            margin-bottom: 2rem;
            text-align: center;
        }

        .selected-patient h3 {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--primary-700);
            margin-bottom: 0.5rem;
        }

        .patient-summary {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-top: 1rem;
        }

        .summary-item {
            background: white;
            padding: 1rem;
            border-radius: var(--radius-md);
            border: 1px solid var(--primary-200);
        }

        /* Prescription Items */
        .prescription-items {
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

        .prescription-list {
            max-height: 200px;
            overflow-y: auto;
        }

        .prescription-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem;
            background: var(--gray-50);
            border: 1px solid var(--gray-200);
            border-radius: var(--radius-md);
            margin-bottom: 0.5rem;
        }

        .medicine-info {
            flex: 1;
        }

        .medicine-name {
            font-weight: 600;
            color: var(--gray-900);
            margin-bottom: 0.25rem;
        }

        .medicine-details {
            font-size: 0.875rem;
            color: var(--gray-600);
        }

        .item-price {
            font-weight: 700;
            color: var(--primary-600);
        }

        /* Membership Section */
        .membership-section {
            background: var(--gold-50);
            border: 2px solid var(--gold-200);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .membership-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
        }

        .membership-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--gold-500), var(--gold-600));
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.125rem;
        }

        .membership-title {
            font-size: 1.125rem;
            font-weight: 700;
            color: var(--gold-700);
        }

        .membership-toggle {
            display: flex;
            align-items: flex-start;
            gap: 1rem;
            padding: 1rem;
            background: white;
            border-radius: var(--radius-md);
            border: 2px solid var(--gold-300);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .membership-toggle:hover {
            border-color: var(--gold-500);
        }

        .membership-toggle input[type="checkbox"] {
            width: 20px;
            height: 20px;
            accent-color: var(--gold-500);
            margin-top: 0.25rem;
        }

        .membership-toggle label {
            cursor: pointer;
            line-height: 1.4;
        }

        /* Points Section */
        .points-section {
            background: var(--primary-50);
            border: 2px solid var(--primary-200);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .points-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .available-points {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--gold-600);
        }

        .points-converter {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .points-input {
            flex: 1;
            padding: 0.75rem;
            border: 2px solid var(--primary-300);
            border-radius: var(--radius-md);
            font-size: 1rem;
        }

        .points-input:focus {
            outline: none;
            border-color: var(--primary-500);
        }

        .conversion-rate {
            font-size: 0.875rem;
            color: var(--gray-600);
            text-align: center;
            background: white;
            padding: 0.75rem;
            border-radius: var(--radius-md);
            border: 1px solid var(--primary-200);
        }

        /* Bill Summary */
        .bill-summary {
            background: var(--gray-50);
            border: 2px solid var(--gray-200);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .bill-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.75rem 0;
            border-bottom: 1px solid var(--gray-200);
        }

        .bill-row:last-child {
            border-bottom: none;
            font-size: 1.25rem;
            font-weight: 700;
            background: var(--primary-50);
            margin: 1rem -1.5rem -1.5rem;
            padding: 1rem 1.5rem;
            border-radius: 0 0 var(--radius-lg) var(--radius-lg);
            color: var(--primary-700);
        }

        .bill-label {
            color: var(--gray-700);
            font-weight: 500;
        }

        .bill-value {
            font-weight: 600;
            color: var(--gray-900);
        }

        .discount-value {
            color: var(--success-600);
        }

        /* Payment Method */
        .payment-method {
            margin-bottom: 2rem;
        }

        .payment-options {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }

        .payment-option {
            padding: 1rem;
            border: 2px solid var(--gray-300);
            border-radius: var(--radius-lg);
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            background: white;
        }

        .payment-option:hover {
            border-color: var(--secondary-400);
            background: var(--secondary-50);
        }

        .payment-option.selected {
            border-color: var(--secondary-500);
            background: var(--secondary-50);
            color: var(--secondary-700);
        }

        .payment-icon {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }

        .payment-label {
            font-weight: 600;
        }

        /* Process Payment Button */
        .process-payment {
            width: 100%;
            padding: 1.25rem;
            background: linear-gradient(135deg, var(--success-500), var(--success-600));
            color: white;
            border: none;
            border-radius: var(--radius-lg);
            font-size: 1.125rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
        }

        .process-payment:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: var(--shadow-xl);
        }

        .process-payment:disabled {
            background: var(--gray-400);
            cursor: not-allowed;
            transform: none;
        }

        /* Success Modal */
        .success-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(8px);
            z-index: 10000;
            align-items: center;
            justify-content: center;
        }

        .success-modal.show {
            display: flex;
        }

        .success-modal-content {
            background: white;
            border-radius: var(--radius-2xl);
            padding: 3rem 2rem;
            max-width: 500px;
            width: 90%;
            text-align: center;
            box-shadow: var(--shadow-2xl);
            animation: slideUp 0.4s ease-out;
            position: relative;
            overflow: hidden;
        }

        .success-modal-content::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: linear-gradient(90deg, var(--success-500), var(--primary-500));
        }

        .success-icon {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, var(--success-100), var(--success-200));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 2rem;
            color: var(--success-600);
            font-size: 3rem;
            animation: checkmark 0.8s ease-out;
        }

        .success-title {
            font-size: 2rem;
            font-weight: 800;
            color: var(--gray-900);
            margin-bottom: 1rem;
        }

        .success-message {
            font-size: 1.125rem;
            color: var(--gray-600);
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .receipt-info {
            background: var(--gray-50);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            margin-bottom: 2rem;
            border: 1px solid var(--gray-200);
        }

        .receipt-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem 0;
            border-bottom: 1px solid var(--gray-200);
        }

        .receipt-item:last-child {
            border-bottom: none;
            font-weight: 700;
        }

        .close-modal-btn {
            width: 100%;
            padding: 1rem 2rem;
            background: var(--primary-500);
            color: white;
            border: none;
            border-radius: var(--radius-lg);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .close-modal-btn:hover {
            background: var(--primary-600);
        }

        /* Debug Link */
        .debug-link {
            background: var(--warning-50);
            border: 1px solid var(--warning-200);
            border-radius: var(--radius-md);
            padding: 1rem;
            margin-top: 1rem;
            text-align: center;
        }

        .debug-link a {
            color: var(--warning-600);
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .debug-link a:hover {
            text-decoration: underline;
        }

        /* Loading States */
        .loading-spinner {
            display: none;
            width: 20px;
            height: 20px;
            border: 2px solid transparent;
            border-top: 2px solid currentColor;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        @keyframes slideUp {
            from {
                transform: translateY(50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes checkmark {
            0% { transform: scale(0); }
            50% { transform: scale(1.2); }
            100% { transform: scale(1); }
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem 1rem;
            color: var(--gray-500);
        }

        .empty-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: var(--gray-300);
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .main-container {
                grid-template-columns: 1fr;
                padding: 1rem;
                gap: 1.5rem;
            }

            .billing-panel {
                position: static;
            }
        }

        @media (max-width: 768px) {
            .search-form {
                flex-direction: column;
            }

            .patient-details {
                grid-template-columns: 1fr;
            }

            .patient-summary {
                grid-template-columns: 1fr;
            }

            .payment-options {
                grid-template-columns: 1fr;
            }

            .user-info {
                gap: 0.5rem;
            }

            .logout-btn span {
                display: none;
            }

            .logout-btn {
                padding: 0.75rem;
                min-width: auto;
            }
        }
    </style>
</head>

<body>
    <!-- Header -->
    <header class="header">
        <div class="header-container">
            <a href="${pageContext.request.contextPath}/cashier/dashboard" class="brand">
                <div class="brand-icon">
                    <i class="fas fa-cash-register"></i>
                </div>
                PharmaCare Cashier
            </a>

            <div class="user-info">
                <div class="user-avatar">CA</div>
                <div class="user-details">
                    <div style="font-weight: 600; font-size: 0.875rem;">Cashier</div>
                    <div style="font-size: 0.75rem; color: var(--gray-500);">Payment Processing</div>
                </div>

                <a href="${pageContext.request.contextPath}/cashier/logout" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-container">
        <!-- Left Panel -->
        <div class="left-panel">
            <!-- Page Header -->
            <div class="page-header">
                <div class="header-content">
                    <h1 class="page-title">
                        <i class="fas fa-cash-register"></i>
                        Payment Processing
                    </h1>
                    <p class="page-subtitle">Search patients and process payments with premium benefits</p>
                </div>
            </div>

            <!-- Search Section -->
            <div class="search-section">
                <h2 class="search-title">
                    <i class="fas fa-search"></i>
                    Find Patient
                </h2>

                <form class="search-form" action="${pageContext.request.contextPath}/cashier/search" method="get">
                    <div class="search-input-container">
                        <i class="fas fa-search search-icon"></i>
                        <input type="text" name="query" class="search-input"
                               placeholder="Search by name or phone number..."
                               value="${query}" required>
                    </div>
                    <button type="submit" class="search-btn">
                        <i class="fas fa-search"></i>
                        Search
                    </button>
                </form>

                <!-- Patient Results -->
                <div class="patients-list" id="patientsList">
                    <c:choose>
                        <c:when test="${not empty patients}">
                            <c:forEach var="patient" items="${patients}">
                                <div class="patient-card"
                                     data-patient-id="${patient.userId}"
                                     data-patient-name="${patient.name}"
                                     data-patient-phone="${patient.phoneNumber}"
                                     data-patient-premium="${patient.premiumMember}"
                                     data-patient-points="${patient.totalPoints}">
                                    <div class="patient-header">
                                        <div class="patient-info">
                                            <h3>${patient.name}</h3>
                                            <div class="patient-phone">
                                                <i class="fas fa-phone"></i>
                                                ${patient.phoneNumber != null ? patient.phoneNumber : 'No phone'}
                                            </div>
                                        </div>
                                        <c:if test="${patient.premiumMember}">
                                            <div class="premium-badge">
                                                <i class="fas fa-crown"></i>
                                                Premium
                                            </div>
                                        </c:if>
                                    </div>

                                    <div class="patient-details">
                                        <div class="detail-item">
                                            <div class="detail-label">Patient ID</div>
                                            <div class="detail-value">${patient.userId}</div>
                                        </div>
                                        <div class="detail-item">
                                            <div class="detail-label">Age</div>
                                            <div class="detail-value">${patient.age != null ? patient.age : 'N/A'}</div>
                                        </div>
                                        <div class="detail-item">
                                            <div class="detail-label">Available Points</div>
                                            <div class="detail-value points-value">
                                                ${patient.premiumMember ? patient.totalPoints : 0}
                                            </div>
                                        </div>
                                        <div class="detail-item">
                                            <div class="detail-label">Member Since</div>
                                            <div class="detail-value">
                                                ${patient.premiumMember && patient.premiumMemberSince != null ? patient.premiumMemberSince : 'Not a member'}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:when test="${not empty query}">
                            <div class="empty-state">
                                <div class="empty-icon">
                                    <i class="fas fa-user-slash"></i>
                                </div>
                                <h3>No patients found</h3>
                                <p>No patients match your search criteria</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <div class="empty-icon">
                                    <i class="fas fa-search"></i>
                                </div>
                                <h3>Search for patients</h3>
                                <p>Enter patient name or phone number to get started</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Right Panel - Billing -->
        <div class="billing-panel">
            <div class="billing-card">
                <div class="billing-header">
                    <h2 class="billing-title">
                        <i class="fas fa-receipt"></i>
                        Payment Bill
                    </h2>
                </div>

                <div class="billing-body">
                    <!-- Selected Patient Display -->
                    <div class="selected-patient" id="selectedPatientDisplay" style="display: none;">
                        <h3 id="selectedPatientName">No patient selected</h3>
                        <div class="patient-summary">
                            <div class="summary-item">
                                <div class="detail-label">Phone</div>
                                <div class="detail-value" id="selectedPatientPhone">-</div>
                            </div>
                            <div class="summary-item">
                                <div class="detail-label">Points</div>
                                <div class="detail-value points-value" id="selectedPatientPoints">0</div>
                            </div>
                        </div>
                    </div>

                    <!-- Prescription Items -->
                    <div class="prescription-items">
                        <h3 class="section-title">
                            <i class="fas fa-pills"></i>
                            Prescription Items
                        </h3>
                        <div class="prescription-list" id="prescriptionList">
                            <div class="empty-state">
                                <div class="empty-icon">
                                    <i class="fas fa-prescription-bottle"></i>
                                </div>
                                <p>Select a patient to view prescriptions</p>
                            </div>
                        </div>
                    </div>

                    <!-- Membership Section -->
                    <div class="membership-section" id="membershipSection" style="display: none;">
                        <div class="membership-header">
                            <div class="membership-icon">
                                <i class="fas fa-crown"></i>
                            </div>
                            <h3 class="membership-title">Premium Membership Upgrade</h3>
                        </div>
                        <div class="membership-toggle" id="membershipToggle">
                            <input type="checkbox" id="addMembership">
                            <label for="addMembership">
                                <strong>Upgrade to Premium Member (+Rs. 500.00)</strong><br>
                                <small>Get points, discounts, and exclusive benefits!</small>
                            </label>
                        </div>
                    </div>

                    <!-- Points Section -->
                    <div class="points-section" id="pointsSection" style="display: none;">
                        <div class="points-header">
                            <h3 class="section-title">
                                <i class="fas fa-star"></i>
                                Use Reward Points
                            </h3>
                            <div class="available-points" id="availablePointsDisplay">0 pts</div>
                        </div>
                        <div class="points-converter">
                            <input type="number" id="pointsToUse" class="points-input"
                                   placeholder="Points to use" min="0" max="0">
                            <button type="button" id="useAllPoints" class="search-btn" style="padding: 0.75rem;">
                                Use All
                            </button>
                        </div>
                        <div class="conversion-rate">
                            1 point = Rs. 1 discount (must keep 50 points balance)
                        </div>
                    </div>

                    <!-- Bill Summary -->
                    <div class="bill-summary" id="billSummary">
                        <div class="bill-row">
                            <span class="bill-label">Medicines Subtotal:</span>
                            <span class="bill-value" id="subtotal">Rs. 0.00</span>
                        </div>
                        <div class="bill-row">
                            <span class="bill-label">Membership Fee:</span>
                            <span class="bill-value" id="membershipFee">Rs. 0.00</span>
                        </div>
                        <div class="bill-row">
                            <span class="bill-label">Points Discount:</span>
                            <span class="bill-value discount-value" id="pointsDiscount">-Rs. 0.00</span>
                        </div>
                        <div class="bill-row">
                            <span class="bill-label">Total Amount:</span>
                            <span class="bill-value" id="finalTotal">Rs. 0.00</span>
                        </div>
                    </div>

                    <!-- Payment Method -->
                    <div class="payment-method">
                        <h3 class="section-title">
                            <i class="fas fa-credit-card"></i>
                            Payment Method
                        </h3>
                        <div class="payment-options">
                            <div class="payment-option" data-method="CASH">
                                <div class="payment-icon">
                                    <i class="fas fa-money-bills"></i>
                                </div>
                                <div class="payment-label">Cash</div>
                            </div>
                            <div class="payment-option" data-method="CARD">
                                <div class="payment-icon">
                                    <i class="fas fa-credit-card"></i>
                                </div>
                                <div class="payment-label">Card</div>
                            </div>
                            <!-- Dynamically shown when points fully cover the bill -->
                            <div class="payment-option" id="pointsPaymentOption" data-method="POINTS" style="display: none;">
                                <div class="payment-icon">
                                    <i class="fas fa-star"></i>
                                </div>
                                <div class="payment-label">Pay with Points</div>
                            </div>
                        </div>
                    </div>

                    <!-- Process Payment Button -->
                    <button class="process-payment" id="processPaymentBtn" disabled>
                        <span class="loading-spinner" id="paymentSpinner"></span>
                        <i class="fas fa-check-circle" id="paymentIcon"></i>
                        Process Payment
                    </button>
                </div>
            </div>
        </div>
    </main>

    <!-- Success Modal -->
    <div id="successModal" class="success-modal">
        <div class="success-modal-content">
            <div class="success-icon">
                <i class="fas fa-check"></i>
            </div>
            <h2 class="success-title">Payment Successful!</h2>
            <p class="success-message">
                <strong>Thank you!</strong> The payment has been processed successfully.
                Here are the transaction details:
            </p>
            <div class="receipt-info" id="receiptInfo">
                <!-- Receipt details will be populated here -->
            </div>
            <button class="close-modal-btn" onclick="closeSuccessModal()">
                <i class="fas fa-home"></i>
                Back to Dashboard
            </button>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        // Global variables
        let selectedPatient = null;
        let selectedPaymentMethod = null;
        let prescriptionItems = [];
        let pointsToUse = 0;
        let addMembership = false;

        // DOM Elements
        const selectedPatientDisplay = document.getElementById('selectedPatientDisplay');
        const selectedPatientName = document.getElementById('selectedPatientName');
        const selectedPatientPhone = document.getElementById('selectedPatientPhone');
        const selectedPatientPoints = document.getElementById('selectedPatientPoints');
        const prescriptionList = document.getElementById('prescriptionList');
        const membershipSection = document.getElementById('membershipSection');
        const pointsSection = document.getElementById('pointsSection');
        const availablePointsDisplay = document.getElementById('availablePointsDisplay');
        const pointsToUseInput = document.getElementById('pointsToUse');
        const addMembershipCheckbox = document.getElementById('addMembership');
        const processPaymentBtn = document.getElementById('processPaymentBtn');
        const paymentSpinner = document.getElementById('paymentSpinner');
        const paymentIcon = document.getElementById('paymentIcon');
        const successModal = document.getElementById('successModal');
        const receiptInfo = document.getElementById('receiptInfo');

        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            initializePaymentOptions();
            initializeMembershipToggle();
            initializePointsCalculator();

            // ENHANCED: Check for selected patient from server-side
            const selectedPatientId = '${selectedPatientId != null ? selectedPatientId : ""}';
            console.log('Server-side selectedPatientId:', selectedPatientId);

            if (selectedPatientId && selectedPatientId.trim() !== '') {
                // Auto-select the patient if it exists in search results
                setTimeout(() => {
                    const patientCard = document.querySelector('[data-patient-id="' + selectedPatientId + '"]');
                    if (patientCard) {
                        console.log('Auto-selecting patient from server:', selectedPatientId);
                        patientCard.click(); // Trigger selection
                    }
                }, 100);
            } else {
                // Try to restore from localStorage/URL
                setTimeout(() => {
                    restorePatientSelection();
                }, 100);
            }

            // ENHANCED: Setup form submission handler
            setupFormSubmissionHandler();
        });

        function setupFormSubmissionHandler() {
            const searchForm = document.querySelector('.search-form');
            if (searchForm) {
                searchForm.addEventListener('submit', function(e) {
                    console.log('Form submitting, current selectedPatient:', selectedPatient);
                    // Add selected patient ID to form if available
                    if (selectedPatient) {
                        // Remove existing hidden input if any
                        const existingInput = this.querySelector('input[name="selectedPatientId"]');
                        if (existingInput) {
                            existingInput.remove();
                        }

                        // Add new hidden input
                        const hiddenInput = document.createElement('input');
                        hiddenInput.type = 'hidden';
                        hiddenInput.name = 'selectedPatientId';
                        hiddenInput.value = selectedPatient.id;
                        this.appendChild(hiddenInput);

                        console.log('Added selectedPatientId to form:', selectedPatient.id);
                    }
                });
            }
        }

        // ENHANCED: Select patient function that preserves state during search
        function selectPatient(id, name, phone, isPremium, points) {
            console.log('Selecting patient:', { id, name, phone, isPremium, points });

            // Remove previous selections
            document.querySelectorAll('.patient-card').forEach(card => {
                card.classList.remove('selected');
            });

            // Select current patient card
            const selectedCard = document.querySelector('[data-patient-id="' + id + '"]');
            if (selectedCard) {
                selectedCard.classList.add('selected');
            }

            // Store selected patient data
            selectedPatient = {
                id: id,
                name: name,
                phone: phone || 'Not provided',
                isPremium: isPremium,
                points: parseInt(points) || 0
            };

            console.log('Selected patient stored:', selectedPatient);

            // ENHANCED: Store in localStorage to persist across page reloads
            localStorage.setItem('selectedPatient', JSON.stringify(selectedPatient));
            localStorage.setItem('selectedPatientTimestamp', Date.now().toString());

            // Update UI immediately
            updateSelectedPatientDisplay();
            loadPrescriptions(id);
            updateMembershipSection();
            updatePointsSection();
            calculateTotal();
            enableProcessButton();

            // ENHANCED: Update URL to preserve state
            const currentUrl = new URL(window.location);
            currentUrl.searchParams.set('selectedPatient', id);
            window.history.replaceState({}, '', currentUrl);
        }

        // Attach click listeners to dynamic patient cards
        document.addEventListener('click', function(e) {
            const card = e.target.closest('.patient-card');
            if (card && card.dataset && card.dataset.patientId) {
                const id = card.dataset.patientId;
                const name = card.dataset.patientName || '';
                const phone = card.dataset.patientPhone || '';
                const isPremium = String(card.dataset.patientPremium).toLowerCase() === 'true';
                const points = parseInt(card.dataset.patientPoints || '0');
                selectPatient(id, name, phone, isPremium, points);
            }
        });

        // ENHANCED: Restore patient selection from localStorage
        function restorePatientSelection() {
            console.log('Attempting to restore patient selection...');

            // Check URL parameters first
            const urlParams = new URLSearchParams(window.location.search);
            const urlPatientId = urlParams.get('selectedPatient');

            // Check localStorage
            const storedPatient = localStorage.getItem('selectedPatient');
            const storedTimestamp = localStorage.getItem('selectedPatientTimestamp');

            // Check if stored data is recent (within 1 hour)
            const isRecentData = storedTimestamp && (Date.now() - parseInt(storedTimestamp)) < 3600000;

            let patientToRestore = null;

            if (urlPatientId) {
                // Priority 1: URL parameter
                const patientCard = document.querySelector('[data-patient-id="' + urlPatientId + '"]');
                if (patientCard) {
                    // Extract data from the card and restore
                    const name = patientCard.querySelector('h3').textContent;
                    const phoneElement = patientCard.querySelector('.patient-phone');
                    const phone = phoneElement ? phoneElement.textContent.replace(/📞|\s*<i[^>]*><\/i>\s*/g, '').trim() : '';
                    const premiumBadge = patientCard.querySelector('.premium-badge');
                    const isPremium = premiumBadge !== null;
                    const pointsElement = patientCard.querySelector('.points-value');
                    const points = pointsElement ? parseInt(pointsElement.textContent) || 0 : 0;

                    patientToRestore = { id: urlPatientId, name, phone, isPremium, points };
                }
            } else if (storedPatient && isRecentData) {
                // Priority 2: Recent localStorage data
                try {
                    const patient = JSON.parse(storedPatient);
                    const patientCard = document.querySelector('[data-patient-id="' + patient.id + '"]');
                    if (patientCard) {
                        patientToRestore = patient;
                    }
                } catch (e) {
                    console.error('Error parsing stored patient:', e);
                    localStorage.removeItem('selectedPatient');
                    localStorage.removeItem('selectedPatientTimestamp');
                }
            }

            if (patientToRestore) {
                console.log('Restoring patient selection:', patientToRestore);
                // Restore selection without triggering localStorage again
                selectedPatient = patientToRestore;
                const patientCard = document.querySelector('[data-patient-id="' + patientToRestore.id + '"]');
                if (patientCard) {
                    patientCard.classList.add('selected');
                    updateSelectedPatientDisplay();
                    loadPrescriptions(patientToRestore.id);
                    updateMembershipSection();
                    updatePointsSection();
                    calculateTotal();
                    enableProcessButton();
                }
            } else {
                // Clean up if no valid patient to restore
                clearPatientSelection();
            }
        }

        // ENHANCED: Clear selection
        function clearPatientSelection() {
            selectedPatient = null;
            prescriptionItems = [];

            // Hide payment panel sections
            if (selectedPatientDisplay) selectedPatientDisplay.style.display = 'none';
            if (membershipSection) membershipSection.style.display = 'none';
            if (pointsSection) pointsSection.style.display = 'none';

            // Reset prescription list
            if (prescriptionList) {
                prescriptionList.innerHTML = '<div class="empty-state"><div class="empty-icon"><i class="fas fa-prescription-bottle"></i></div><p>Select a patient to view prescriptions</p></div>';
            }

            // Reset totals
            updateBillDisplay(0, 0, 0, 0);

            // Disable process button
            if (processPaymentBtn) processPaymentBtn.disabled = true;

            // Clean up localStorage
            localStorage.removeItem('selectedPatient');
            localStorage.removeItem('selectedPatientTimestamp');

            // Clean up URL
            const currentUrl = new URL(window.location);
            currentUrl.searchParams.delete('selectedPatient');
            window.history.replaceState({}, '', currentUrl);
        }

        // Rest of your existing functions
        function updateSelectedPatientDisplay() {
            if (!selectedPatient) return;

            selectedPatientDisplay.style.display = 'block';
            selectedPatientName.textContent = selectedPatient.name;
            selectedPatientPhone.textContent = selectedPatient.phone;
            selectedPatientPoints.textContent = selectedPatient.points;
        }

        function loadPrescriptions(patientId) {
            console.log('Loading prescriptions for patient:', patientId);

            prescriptionList.innerHTML = '<div class="empty-state"><div class="empty-icon"><i class="fas fa-spinner fa-spin"></i></div><p>Loading prescriptions...</p></div>';

            fetch('${pageContext.request.contextPath}/cashier/prescriptions/' + patientId)
                .then(response => {
                    console.log('Response status:', response.status);
                    if (!response.ok) {
                        throw new Error('Network response was not ok: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Prescriptions loaded:', data);

                    if (data.error) {
                        throw new Error(data.message || 'Unknown error');
                    }

                    prescriptionItems = Array.isArray(data) ? data : [];
                    console.log('Prescription items set:', prescriptionItems);

                    updatePrescriptionList();
                    calculateTotal();
                    enableProcessButton();
                })
                .catch(error => {
                    console.error('Error loading prescriptions:', error);
                    prescriptionItems = [];

                    prescriptionList.innerHTML =
                        '<div class="empty-state">' +
                            '<div class="empty-icon"><i class="fas fa-exclamation-circle"></i></div>' +
                            '<h3>Error Loading Prescriptions</h3>' +
                            '<p>Unable to load prescription data for this patient.</p>' +
                            '<p style="font-size: 0.8rem; color: var(--gray-500);">Error: ' + error.message + '</p>' +
                        '</div>' +
                        '<div class="debug-link">' +
                            '<a href="${pageContext.request.contextPath}/cashier/debug/prescriptions/' + patientId + '" target="_blank">' +
                                '<i class="fas fa-bug"></i> Debug Prescriptions' +
                            '</a>' +
                        '</div>';

                    enableProcessButton();
                });
        }

        function updatePrescriptionList() {
            if (!prescriptionItems || prescriptionItems.length === 0) {
                prescriptionList.innerHTML = '<div class="empty-state"><div class="empty-icon"><i class="fas fa-prescription-bottle"></i></div><p>No pending prescriptions for this patient</p></div>';
                return;
            }

            let html = '';
            prescriptionItems.forEach(item => {
                console.log('Processing prescription item:', item);

                const quantity = item.qty || item.quantity || 0;
                const medicine = item.medicine || {};
                const medicineName = medicine.name || 'Unknown Medicine';
                const medicinePrice = medicine.price || 0;
                const medicineType = medicine.type || 'Unknown';
                const medicineCompany = medicine.company || 'Unknown';

                const totalPrice = quantity * medicinePrice;

                html += '<div class="prescription-item">' +
                    '<div class="medicine-info">' +
                    '<div class="medicine-name">' + medicineName + '</div>' +
                    '<div class="medicine-details">Qty: ' + quantity + ' | ' + medicineType + ' | ' + medicineCompany + '</div>' +
                    '</div>' +
                    '<div class="item-price">Rs. ' + totalPrice.toFixed(2) + '</div>' +
                    '</div>';
            });
            prescriptionList.innerHTML = html;

            console.log('Updated prescription list with', prescriptionItems.length, 'items');
        }

        function updateMembershipSection() {
            if (!selectedPatient) return;

            if (!selectedPatient.isPremium) {
                membershipSection.style.display = 'block';
                addMembershipCheckbox.checked = false;
                addMembership = false;
            } else {
                membershipSection.style.display = 'none';
                addMembership = false;
            }
        }

        function updatePointsSection() {
            if (!selectedPatient) return;

            if (selectedPatient.isPremium && selectedPatient.points > 0) {
                pointsSection.style.display = 'block';
                availablePointsDisplay.textContent = selectedPatient.points + ' pts';
                pointsToUseInput.max = selectedPatient.points;
                pointsToUseInput.value = 0;
                pointsToUse = 0;
            } else {
                pointsSection.style.display = 'none';
                pointsToUse = 0;
            }
        }

        function initializeMembershipToggle() {
            addMembershipCheckbox.addEventListener('change', function() {
                addMembership = this.checked;
                console.log('Membership toggle:', addMembership);
                calculateTotal();
            });
        }

        function initializePointsCalculator() {
            pointsToUseInput.addEventListener('input', function() {
                const inputValue = parseInt(this.value) || 0;

                // Reserve 50 points balance; minimum redeem is now 1 point
                if (inputValue <= 0) {
                    this.value = 0;
                    pointsToUse = 0;
                } else {
                    const subtotal = prescriptionItems.reduce((total, item) => {
                        const quantity = item.qty || item.quantity || 0;
                        const price = (item.medicine && item.medicine.price) || 0;
                        return total + (quantity * price);
                    }, 0);
                    const membershipFeeAmount = addMembership ? 500 : 0;
                    const payableAmount = Math.max(0, Math.floor(subtotal + membershipFeeAmount));
                    const availablePoints = selectedPatient ? selectedPatient.points : 0;
                    const redeemableOverReserve = Math.max(0, availablePoints - 50);
                    const maxRedeemable = Math.min(redeemableOverReserve, payableAmount);
                    pointsToUse = Math.min(inputValue, maxRedeemable);
                    if (pointsToUse !== inputValue) {
                        this.value = pointsToUse;
                    }
                }
                calculateTotal();
                checkIfPaymentCanBeFullyCovered();
            });

            document.getElementById('useAllPoints').addEventListener('click', function() {
                if (selectedPatient && selectedPatient.points > 0) {
                    // Only use points if we can keep 50 in reserve
                    if (selectedPatient.points > 50) {
                        const subtotal = prescriptionItems.reduce((total, item) => {
                            const quantity = item.qty || item.quantity || 0;
                            const price = (item.medicine && item.medicine.price) || 0;
                            return total + (quantity * price);
                        }, 0);
                        const membershipFeeAmount = addMembership ? 500 : 0;
                        const payableAmount = Math.max(0, Math.floor(subtotal + membershipFeeAmount));
                        const redeemableOverReserve = Math.max(0, selectedPatient.points - 50);
                        const maxRedeemable = Math.min(redeemableOverReserve, payableAmount);
                        pointsToUse = maxRedeemable;
                        pointsToUseInput.value = pointsToUse;
                        calculateTotal();
                        checkIfPaymentCanBeFullyCovered();
                    } else {
                        alert('You must keep a 50-point balance. Available to redeem: 0');
                    }
                }
            });
        }
        function initializePaymentOptions() {
            document.querySelectorAll('.payment-option').forEach(option => {
                option.addEventListener('click', function() {
                    document.querySelectorAll('.payment-option').forEach(opt => opt.classList.remove('selected'));
                    this.classList.add('selected');
                    selectedPaymentMethod = this.dataset.method;
                    console.log('Selected payment method:', selectedPaymentMethod);
                    enableProcessButton();
                });
            });
        }

        function calculateTotal() {
            if (!selectedPatient || !prescriptionItems || prescriptionItems.length === 0) {
                updateBillDisplay(0, 0, 0, 0);
                return;
            }

            const subtotal = prescriptionItems.reduce((total, item) => {
                const quantity = item.qty || item.quantity || 0;
                const price = (item.medicine && item.medicine.price) || 0;
                return total + (quantity * price);
            }, 0);

            const membershipFeeAmount = addMembership ? 500 : 0;

            // NEW: 1 point = 1 rupee
            const payableAmount = Math.max(0, Math.floor(subtotal + membershipFeeAmount));
            const availablePoints = selectedPatient ? selectedPatient.points : 0;
            const redeemableOverReserve = Math.max(0, availablePoints - 50);
            const maxRedeemable = Math.min(redeemableOverReserve, payableAmount);
            if (pointsToUse > maxRedeemable) {
                pointsToUse = maxRedeemable;
                pointsToUseInput.value = pointsToUse;
            }
            const pointsDiscountAmount = pointsToUse;
            const finalTotal = Math.max(0, subtotal + membershipFeeAmount - pointsDiscountAmount);

            console.log('Calculated totals:', {
                subtotal,
                membershipFeeAmount,
                pointsDiscountAmount,
                finalTotal
            });

            updateBillDisplay(subtotal, membershipFeeAmount, pointsDiscountAmount, finalTotal);
        }

        function updateBillDisplay(subtotal, membershipFee, pointsDiscount, finalTotal) {
            document.getElementById('subtotal').textContent = 'Rs. ' + subtotal.toFixed(2);
            document.getElementById('membershipFee').textContent = 'Rs. ' + membershipFee.toFixed(2);
            document.getElementById('pointsDiscount').textContent = '-Rs. ' + pointsDiscount.toFixed(2);
            document.getElementById('finalTotal').textContent = 'Rs. ' + finalTotal.toFixed(2);

            // Toggle Pay with Points option visibility and auto-select if fully covered
            const pointsOption = document.getElementById('pointsPaymentOption');
            const pointsCoverAll = finalTotal === 0 && (selectedPatient && (pointsToUse || 0) >= 1);
            if (pointsOption) {
                pointsOption.style.display = pointsCoverAll ? 'block' : 'none';
            }
            if (pointsCoverAll) {
                document.querySelectorAll('.payment-option').forEach(opt => opt.classList.remove('selected'));
                if (pointsOption) {
                    pointsOption.classList.add('selected');
                }
                selectedPaymentMethod = 'POINTS';
            }
        }

        function enableProcessButton() {
            const subtotal = prescriptionItems.reduce((total, item) => {
                const quantity = item.qty || item.quantity || 0;
                const price = (item.medicine && item.medicine.price) || 0;
                return total + (quantity * price);
            }, 0);
            const membershipFeeAmount = addMembership ? 500 : 0;
            const payableAmount = Math.max(0, Math.floor(subtotal + membershipFeeAmount));
            const finalTotal = Math.max(0, payableAmount - (pointsToUse || 0));

            const pointsCoverAll = finalTotal === 0 && (selectedPatient && (pointsToUse || 0) >= 1);

            const canProcess = selectedPatient && (pointsCoverAll || selectedPaymentMethod) &&
                             prescriptionItems && prescriptionItems.length > 0;
            processPaymentBtn.disabled = !canProcess;

            console.log('Process button state:', {
                selectedPatient: !!selectedPatient,
                selectedPaymentMethod: !!selectedPaymentMethod,
                pointsCoverAll,
                prescriptionItems: prescriptionItems ? prescriptionItems.length : 0,
                canProcess
            });
        }

        // COMPLETE: Payment processing code
        processPaymentBtn.addEventListener('click', function() {
            if (!selectedPatient) {
                alert('Please select a patient');
                return;
            }

            if (!prescriptionItems || prescriptionItems.length === 0) {
                alert('No prescription items found for this patient');
                return;
            }

            // Show loading state
            this.disabled = true;
            paymentSpinner.style.display = 'inline-block';
            paymentIcon.style.display = 'none';
            this.innerHTML = '<span class="loading-spinner" style="display: inline-block; width: 20px; height: 20px; border: 2px solid transparent; border-top: 2px solid currentColor; border-radius: 50%; animation: spin 1s linear infinite;"></span> Processing Payment...';

            // Calculate totals - handle DTO format
            const subtotal = prescriptionItems.reduce((total, item) => {
                const quantity = item.qty || item.quantity || 0;
                const price = (item.medicine && item.medicine.price) || 0;
                return total + (quantity * price);
            }, 0);

            const membershipFeeAmount = addMembership ? 500 : 0;
            const payableAmount = Math.max(0, Math.floor(subtotal + membershipFeeAmount));
            const availablePoints = selectedPatient ? selectedPatient.points : 0;
            const redeemableOverReserve = Math.max(0, availablePoints - 50);
            const maxRedeemable = Math.min(redeemableOverReserve, payableAmount);
            if (pointsToUse > maxRedeemable) {
                pointsToUse = maxRedeemable;
            }
            const pointsDiscountAmount = pointsToUse; // 1 point = 1 rupee
            const finalTotal = Math.max(0, subtotal + membershipFeeAmount - pointsDiscountAmount);

            // If points fully cover the bill (and at least 50 are used), allow without payment method
            const pointsCoverAll = finalTotal === 0 && pointsToUse >= 50;
            if (!pointsCoverAll && !selectedPaymentMethod) {
                alert('Please select a payment method');
                resetProcessButton();
                return;
            }

            const methodUsed = pointsCoverAll ? 'POINTS' : selectedPaymentMethod;
            window.lastPaymentMethodUsed = methodUsed;

            // Prepare payment data - handle DTO format
            const paymentData = {
                patientId: selectedPatient.id,
                paymentMethod: methodUsed,
                pointsUsed: pointsToUse,
                addMembership: addMembership,
                subtotal: subtotal,
                membershipFee: membershipFeeAmount,
                pointsDiscount: pointsDiscountAmount,
                finalTotal: finalTotal,
                prescriptionItems: prescriptionItems.map(item => ({
                    prescriptionId: item.id,
                    medicineId: item.medicine ? item.medicine.id : null,
                    quantity: item.qty || item.quantity || 0,
                    price: item.medicine ? item.medicine.price : 0
                }))
            };

            console.log('Sending payment data:', paymentData);

            // Process payment
            fetch('${pageContext.request.contextPath}/cashier/process-payment', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(paymentData)
            })
            .then(response => {
                console.log('Payment response status:', response.status);
                if (!response.ok) {
                    throw new Error('Payment processing failed with status: ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                console.log('Payment response:', data);
                if (data.success) {
                    showSuccessModal(data);
                } else {
                    alert('Payment failed: ' + (data.message || 'Unknown error'));
                    resetProcessButton();
                }
            })
            .catch(error => {
                console.error('Error processing payment:', error);
                alert('Network error occurred. Please try again.\nError: ' + error.message);
                resetProcessButton();
            });
        });

        function resetProcessButton() {
            processPaymentBtn.disabled = false;
            paymentSpinner.style.display = 'none';
            paymentIcon.style.display = 'inline-block';
            processPaymentBtn.innerHTML = '<i class="fas fa-check-circle"></i> Process Payment';
        }

        function showSuccessModal(data) {
            // Populate receipt information
            let receiptHtml = '';

            receiptHtml += '<div class="receipt-item"><span>Receipt ID:</span><span>' + (data.receiptId || 'N/A') + '</span></div>';
            receiptHtml += '<div class="receipt-item"><span>Patient:</span><span>' + selectedPatient.name + '</span></div>';
            const methodShown = window.lastPaymentMethodUsed || selectedPaymentMethod || 'POINTS';
            receiptHtml += '<div class="receipt-item"><span>Payment Method:</span><span>' + methodShown + '</span></div>';
            receiptHtml += '<div class="receipt-item"><span>Total Amount:</span><span>Rs. ' + (data.finalTotal ? data.finalTotal.toFixed(2) : '0.00') + '</span></div>';

            if (data.pointsEarned && data.pointsEarned > 0) {
                receiptHtml += '<div class="receipt-item"><span>Points Earned:</span><span>' + data.pointsEarned + ' pts</span></div>';
            }

            if (data.pointsUsed && data.pointsUsed > 0) {
                receiptHtml += '<div class="receipt-item"><span>Points Used:</span><span>' + data.pointsUsed + ' pts</span></div>';
            }

            receiptInfo.innerHTML = receiptHtml;

            // Show modal
            successModal.classList.add('show');
        }

        function closeSuccessModal() {
            successModal.classList.remove('show');
            // Clear patient selection and reload
            clearPatientSelection();
            setTimeout(function() {
                window.location.href = '${pageContext.request.contextPath}/cashier/dashboard';
            }, 500);
        }

        // Close modal when clicking outside
        successModal.addEventListener('click', function(e) {
            if (e.target === this) {
                closeSuccessModal();
            }
        });

        // Close modal with Escape key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && successModal.classList.contains('show')) {
                closeSuccessModal();
            }
        });
    </script>
</body>
</html>
