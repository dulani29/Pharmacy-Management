<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title>New Prescription • Pharmacy Management</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

  <style>
    :root {
      --primary-600: #4f46e5;
      --primary-700: #4338ca;
      --primary-50: #eef2ff;
      --primary-100: #e0e7ff;
      --gray-50: #f9fafb;
      --gray-100: #f3f4f6;
      --gray-200: #e5e7eb;
      --gray-300: #d1d5db;
      --gray-400: #9ca3af;
      --gray-500: #6b7280;
      --gray-600: #4b5563;
      --gray-700: #374151;
      --gray-900: #111827;
      --green-50: #f0fdf4;
      --green-500: #22c55e;
      --green-100: #dcfce7;
      --blue-50: #eff6ff;
      --blue-500: #3b82f6;
      --blue-100: #dbeafe;
      --yellow-50: #fffbeb;
      --yellow-500: #f59e0b;
      --yellow-100: #fef3c7;
      --red-50: #fef2f2;
      --red-500: #ef4444;
      --red-100: #fee2e2;
      --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
      --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1);
      --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1);
      --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1);
      --border-radius: 8px;
      --border-radius-lg: 12px;
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    body {
      font-family: 'Inter', system-ui, -apple-system, sans-serif;
      background-color: var(--gray-50);
      color: var(--gray-900);
      line-height: 1.5;
    }

    /* Header & Navigation */
    .header {
      background: white;
      border-bottom: 1px solid var(--gray-200);
      padding: 1rem 0;
      position: sticky;
      top: 0;
      z-index: 50;
      box-shadow: var(--shadow-sm);
    }

    .nav-container {
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 1.5rem;
    }

    .logo {
      font-size: 1.5rem;
      font-weight: 700;
      color: var(--primary-600);
    }

    .nav-links {
      display: flex;
      gap: 2rem;
    }

    .nav-links a {
      color: var(--gray-600);
      text-decoration: none;
      font-weight: 500;
      padding: 0.5rem 1rem;
      border-radius: var(--border-radius);
      transition: all 0.2s;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .nav-links a:hover {
      background: var(--primary-50);
      color: var(--primary-600);
    }

    /* Main Content */
    .main-container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 2rem 1.5rem;
    }

    .page-header {
      margin-bottom: 2rem;
    }

    .page-title {
      font-size: 2rem;
      font-weight: 700;
      color: var(--gray-900);
      margin-bottom: 0.5rem;
    }

    .page-subtitle {
      color: var(--gray-600);
      font-size: 1.125rem;
    }

    /* Card Layout */
    .card {
      background: white;
      border-radius: var(--border-radius-lg);
      box-shadow: var(--shadow-md);
      overflow: hidden;
      margin-bottom: 2rem;
    }

    .card-header {
      padding: 1.5rem;
      border-bottom: 1px solid var(--gray-200);
      background: var(--gray-50);
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .card-title {
      font-size: 1.25rem;
      font-weight: 600;
      color: var(--gray-900);
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .card-body {
      padding: 1.5rem;
    }

    /* Flash Messages */
    .toast {
      position: fixed;
      top: 1rem;
      right: 1rem;
      max-width: 400px;
      padding: 1rem 1.5rem;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow-lg);
      z-index: 1000;
      opacity: 1;
      transform: translateX(0);
      transition: all 0.3s ease-out;
      display: flex;
      align-items: center;
      gap: 0.75rem;
    }

    .toast.success {
      background: var(--green-50);
      border: 1px solid var(--green-500);
      color: var(--gray-900);
    }

    .toast.error {
      background: var(--red-50);
      border: 1px solid var(--red-500);
      color: var(--gray-900);
    }

    .toast.hide {
      opacity: 0;
      transform: translateX(100%);
    }

    /* Patient Search */
    .patient-search-section {
      display: flex;
      gap: 1rem;
      margin-bottom: 1.5rem;
      flex-wrap: wrap;
    }

    .search-input {
      flex: 1;
      min-width: 250px;
      padding: 0.75rem 1rem;
      border: 1px solid var(--gray-300);
      border-radius: var(--border-radius);
      font-size: 1rem;
      transition: all 0.2s;
    }

    .search-input:focus {
      outline: none;
      border-color: var(--primary-600);
      box-shadow: 0 0 0 3px rgb(79 70 229 / 0.1);
    }

    .btn {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
      padding: 0.75rem 1.5rem;
      border: none;
      border-radius: var(--border-radius);
      font-weight: 500;
      font-size: 1rem;
      cursor: pointer;
      transition: all 0.2s;
      text-decoration: none;
      white-space: nowrap;
    }

    .btn-primary {
      background: var(--primary-600);
      color: white;
    }

    .btn-primary:hover {
      background: var(--primary-700);
    }

    .btn-secondary {
      background: var(--gray-100);
      color: var(--gray-700);
      border: 1px solid var(--gray-300);
    }

    .btn-secondary:hover {
      background: var(--gray-200);
    }

    .btn-success {
      background: var(--green-500);
      color: white;
    }

    .btn-success:hover {
      background: #16a34a;
    }

    .btn-lg {
      padding: 1rem 2rem;
      font-size: 1.125rem;
    }

    /* Patient Cards */
    .patients-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 1rem;
      margin-bottom: 1.5rem;
    }

    .patient-card {
      background: var(--gray-50);
      border: 2px solid var(--gray-200);
      border-radius: var(--border-radius);
      padding: 1rem;
      cursor: pointer;
      transition: all 0.2s;
      position: relative;
    }

    .patient-card:hover {
      border-color: var(--primary-600);
      background: var(--primary-50);
    }

    .patient-card.selected {
      border-color: var(--primary-600);
      background: var(--primary-50);
      box-shadow: 0 0 0 3px rgb(79 70 229 / 0.1);
    }

    .patient-info h4 {
      font-size: 1.125rem;
      font-weight: 600;
      color: var(--gray-900);
      margin-bottom: 0.5rem;
    }

    .patient-details {
      display: flex;
      flex-wrap: wrap;
      gap: 0.75rem;
      margin-bottom: 0.75rem;
    }

    .patient-detail {
      font-size: 0.875rem;
      color: var(--gray-600);
      display: flex;
      align-items: center;
      gap: 0.25rem;
    }

    .premium-badge {
      position: absolute;
      top: 0.5rem;
      right: 0.5rem;
      background: linear-gradient(135deg, #f59e0b, #d97706);
      color: white;
      padding: 0.25rem 0.5rem;
      border-radius: 9999px;
      font-size: 0.75rem;
      font-weight: 600;
      display: flex;
      align-items: center;
      gap: 0.25rem;
    }

    .points-display {
      background: var(--blue-100);
      color: var(--blue-500);
      padding: 0.25rem 0.5rem;
      border-radius: var(--border-radius);
      font-size: 0.875rem;
      font-weight: 500;
    }

    /* Form */
    .form-section {
      margin-bottom: 2rem;
    }

    .form-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 1.5rem;
      margin-bottom: 2rem;
    }

    .form-group {
      display: flex;
      flex-direction: column;
    }

    .form-label {
      font-weight: 500;
      color: var(--gray-700);
      margin-bottom: 0.5rem;
    }

    .form-input {
      padding: 0.75rem;
      border: 1px solid var(--gray-300);
      border-radius: var(--border-radius);
      font-size: 1rem;
      transition: all 0.2s;
    }

    .form-input:focus {
      outline: none;
      border-color: var(--primary-600);
      box-shadow: 0 0 0 3px rgb(79 70 229 / 0.1);
    }

    .form-input:read-only {
      background: var(--gray-100);
      color: var(--gray-600);
    }

    /* Medicine Table */
    .medicines-section {
      margin-top: 2rem;
    }

    .medicine-search {
      margin-bottom: 1.5rem;
    }

    .table-container {
      overflow-x: auto;
      border: 1px solid var(--gray-200);
      border-radius: var(--border-radius);
    }

    .medicine-table {
      width: 100%;
      border-collapse: collapse;
      background: white;
    }

    .medicine-table th {
      background: var(--gray-50);
      padding: 1rem;
      text-align: left;
      font-weight: 600;
      color: var(--gray-700);
      border-bottom: 1px solid var(--gray-200);
      position: sticky;
      top: 0;
    }

    .medicine-table td {
      padding: 1rem;
      border-bottom: 1px solid var(--gray-100);
      vertical-align: middle;
    }

    .medicine-table tr:hover {
      background: var(--gray-50);
    }

    .medicine-table tr.selected {
      background: var(--primary-50);
    }

    .checkbox {
      width: 1.25rem;
      height: 1.25rem;
      border-radius: 4px;
      cursor: pointer;
    }

    .qty-input {
      width: 80px;
      padding: 0.5rem;
      border: 1px solid var(--gray-300);
      border-radius: var(--border-radius);
      text-align: center;
    }

    .stock-badge {
      padding: 0.25rem 0.75rem;
      border-radius: 9999px;
      font-size: 0.875rem;
      font-weight: 500;
    }

    .stock-low { background: var(--red-50); color: var(--red-500); }
    .stock-medium { background: var(--yellow-50); color: var(--yellow-500); }
    .stock-high { background: var(--green-50); color: var(--green-500); }

    /* Summary Section */
    .summary-section {
      margin-top: 2rem;
      padding: 1.5rem;
      background: var(--primary-50);
      border-radius: var(--border-radius);
      border: 1px solid var(--primary-600);
    }

    .total-display {
      font-size: 1.5rem;
      font-weight: 700;
      color: var(--primary-700);
    }

    /* Create New Patient Section */
    .create-patient-section {
      background: var(--green-50);
      border: 2px dashed var(--green-500);
      border-radius: var(--border-radius);
      padding: 1.5rem;
      text-align: center;
      margin-bottom: 1.5rem;
    }

    .create-patient-section h4 {
      color: var(--green-500);
      margin-bottom: 0.5rem;
    }

    /* Empty State */
    .empty-state {
      text-align: center;
      padding: 3rem 1rem;
      color: var(--gray-500);
    }

    .empty-state i {
      font-size: 3rem;
      margin-bottom: 1rem;
      color: var(--gray-300);
    }

    /* Search Results */
    .search-results {
      margin-top: 1rem;
      border: 1px solid var(--gray-200);
      border-radius: var(--border-radius);
      background: white;
      box-shadow: var(--shadow-md);
      max-height: 400px;
      overflow-y: auto;
    }

    .search-results-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 1rem;
      border-bottom: 1px solid var(--gray-200);
      background: var(--gray-50);
    }

    .search-results-header h4 {
      margin: 0;
      color: var(--gray-700);
    }

    .search-results-list {
      padding: 0.5rem;
    }

    .search-result-item {
      display: flex;
      align-items: center;
      padding: 0.75rem;
      border-radius: var(--border-radius);
      cursor: pointer;
      transition: all 0.2s;
      border: 1px solid transparent;
      margin-bottom: 0.5rem;
    }

    .search-result-item:hover {
      background: var(--primary-50);
      border-color: var(--primary-600);
    }

    .search-result-item:last-child {
      margin-bottom: 0;
    }

    .search-result-info {
      flex: 1;
    }

    .search-result-name {
      font-weight: 600;
      color: var(--gray-900);
      margin-bottom: 0.25rem;
    }

    .search-result-details {
      display: flex;
      gap: 1rem;
      font-size: 0.875rem;
      color: var(--gray-600);
    }

    .search-result-price {
      font-weight: 600;
      color: var(--primary-600);
    }

    .search-result-stock {
      padding: 0.25rem 0.5rem;
      border-radius: 9999px;
      font-size: 0.75rem;
      font-weight: 500;
    }

    .search-result-stock.high {
      background: var(--green-50);
      color: var(--green-500);
    }

    .search-result-stock.medium {
      background: var(--yellow-50);
      color: var(--yellow-500);
    }

    .search-result-stock.low {
      background: var(--red-50);
      color: var(--red-500);
    }

    .search-result-actions {
      display: flex;
      gap: 0.5rem;
    }

    .btn-sm {
      padding: 0.5rem 0.75rem;
      font-size: 0.875rem;
    }

    .btn-danger {
      background: var(--red-500);
      color: white;
    }

    .btn-danger:hover {
      background: #dc2626;
    }

    .btn-xs {
      padding: 0.25rem 0.5rem;
      font-size: 0.75rem;
    }

    /* Delete button in table */
    .medicine-table .delete-btn {
      background: var(--red-500);
      color: white;
      border: none;
      border-radius: 4px;
      padding: 0.25rem 0.5rem;
      font-size: 0.75rem;
      cursor: pointer;
      transition: all 0.2s;
      display: flex;
      align-items: center;
      gap: 0.25rem;
    }

    .medicine-table .delete-btn:hover {
      background: #dc2626;
    }

    .medicine-table .delete-btn:disabled {
      background: var(--gray-300);
      cursor: not-allowed;
    }

    /* Recent Patients Section */
    .recent-patients-section {
      margin-top: 1rem;
    }

    .card-subtitle {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      margin-bottom: 0.75rem;
      font-weight: 700;
      color: var(--gray-700);
    }

    .recent-patients-list {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
      gap: 0.75rem;
    }

    .recent-patients-list .patient-card {
      border: 1px solid var(--gray-200);
      border-radius: 12px;
      padding: 0.75rem;
      cursor: pointer;
      transition: all 0.2s;
      background: white;
    }

    .recent-patients-list .patient-card:hover {
      border-color: var(--primary-600);
      background: var(--primary-50);
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    /* Responsive */
    @media (max-width: 768px) {
      .nav-container {
        flex-direction: column;
        gap: 1rem;
      }

      .nav-links {
        gap: 1rem;
      }

      .main-container {
        padding: 1rem;
      }

      .form-grid {
        grid-template-columns: 1fr;
      }

      .patients-grid {
        grid-template-columns: 1fr;
      }

      .patient-search-section {
        flex-direction: column;
      }

      .search-input {
        min-width: auto;
      }

      .toast {
        right: 1rem;
        left: 1rem;
        max-width: none;
      }
    }
  </style>
</head>
<body>

  <!-- Header -->
  <header class="header">
    <div class="nav-container">
      <div class="logo">
        <i class="fas fa-pills"></i> PharmaCare
      </div>
      <nav class="nav-links">
        <a href="${pageContext.request.contextPath}/pharmacist-dashboard">
          <i class="fas fa-home"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/pharmacist/prescriptions">
          <i class="fas fa-list"></i> Prescriptions
        </a>
      </nav>
    </div>
  </header>

  <!-- Toast Messages -->
  <c:if test="${not empty success}">
    <div id="toast-success" class="toast success">
      <i class="fas fa-check-circle"></i>
      <div>
        <strong>${success}</strong>
        <c:if test="${not empty total}">
          <br><span class="total-display">${total}</span>
        </c:if>
      </div>
    </div>
  </c:if>
  <c:if test="${not empty error}">
    <div id="toast-error" class="toast error">
      <i class="fas fa-exclamation-triangle"></i>
      <strong>${error}</strong>
    </div>
  </c:if>

  <!-- Main Content -->
  <main class="main-container">
    <div class="page-header">
      <h1 class="page-title">New Prescription</h1>
      <p class="page-subtitle">Search for existing patient or create a new prescription</p>
    </div>

    <!-- Patient Search Section -->
    <div class="card">
      <div class="card-header">
        <h2 class="card-title">
          <i class="fas fa-user-search"></i>
          Find Patient
        </h2>
      </div>
      <div class="card-body">
        <div class="patient-search-section">
          <input type="text" id="patient-search" class="search-input"
                 placeholder="Search by patient name or phone number..."
                 value="${param.patientQuery}">
          <button type="button" id="search-patient-btn" class="btn btn-primary">
            <i class="fas fa-search"></i> Search Patient
          </button>
          <button type="button" id="new-patient-btn" class="btn btn-secondary">
            <i class="fas fa-user-plus"></i> New Patient
          </button>
        </div>

        <!-- Patient Results -->
        <div id="patient-results">
          <c:choose>
            <c:when test="${not empty patients}">
              <div class="patients-grid">
                <c:forEach var="patient" items="${patients}">
                  <div class="patient-card" onclick="selectPatient('${patient.userId}', '${patient.name}', '${patient.age}', '${patient.phoneNumber}', ${patient.isPremiumMember()}, ${patient.totalPoints})">
                    <c:if test="${patient.isPremiumMember()}">
                      <div class="premium-badge">
                        <i class="fas fa-crown"></i> Premium
                      </div>
                    </c:if>
                    <div class="patient-info">
                      <h4>${patient.name}</h4>
                      <div class="patient-details">
                        <div class="patient-detail">
                          <i class="fas fa-id-card"></i>
                          ID: ${patient.userId}
                        </div>
                        <div class="patient-detail">
                          <i class="fas fa-birthday-cake"></i>
                          Age: ${patient.age != null ? patient.age : 'N/A'}
                        </div>
                        <div class="patient-detail">
                          <i class="fas fa-phone"></i>
                          ${patient.phoneNumber != null ? patient.phoneNumber : 'No phone'}
                        </div>
                      </div>
                      <c:if test="${patient.isPremiumMember() && patient.totalPoints > 0}">
                        <div class="points-display">
                          <i class="fas fa-star"></i> ${patient.totalPoints} points available
                        </div>
                      </c:if>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </c:when>
            <c:when test="${not empty param.patientQuery}">
              <div class="empty-state">
                <i class="fas fa-user-slash"></i>
                <h3>No patients found</h3>
                <p>No patients match your search criteria. Try a different search term or create a new patient.</p>
              </div>
            </c:when>
            <c:otherwise>
              <div class="empty-state">
                <i class="fas fa-search"></i>
                <h3>Search for patients</h3>
                <p>Enter patient name or phone number to find existing patients</p>
              </div>
            </c:otherwise>
          </c:choose>
        </div>

        <!-- Recent Patients Section -->
        <c:if test="${empty patients && not empty recentPatients}">
          <div class="recent-patients-section" style="margin-top:1rem;">
            <div class="card-subtitle" style="margin-bottom:.5rem; font-weight:700; color:var(--gray-700);">
              <i class="fas fa-clock"></i> Recent Patients
            </div>
            <div class="recent-patients-list" style="display:grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap:.75rem;">
              <c:forEach var="rp" items="${recentPatients}">
                <div class="patient-card" style="border:1px solid var(--gray-200); border-radius:12px; padding:.75rem; cursor:pointer;"
                     onclick="selectPatient('${rp.userId}', '${rp.name}', '${rp.age}', '${rp.phoneNumber}', ${rp.premiumMember}, ${rp.totalPoints})">
                  <div style="font-weight:700;">${rp.name}</div>
                  <div style="color:var(--gray-500); font-size:.9rem;">${rp.userId} • ${rp.phoneNumber}</div>
                  <div style="color:var(--gray-400); font-size:.8rem; margin-top:.25rem;">
                    <i class="fas fa-user"></i> Patient ID: ${rp.userId}
                  </div>
                </div>
              </c:forEach>
            </div>
          </div>
        </c:if>

        <!-- Create New Patient Option -->
        <div id="create-new-patient" class="create-patient-section" style="display: none;">
          <h4><i class="fas fa-user-plus"></i> Create New Patient</h4>
          <p>Patient not found? Fill in the patient information below to create a new patient record.</p>
        </div>
      </div>
    </div>

    <!-- Medicine Search Section -->
    <div class="card">
      <div class="card-header">
        <h2 class="card-title">
          <i class="fas fa-pills"></i>
          Search Medicines
        </h2>
      </div>
      <div class="card-body">
        <div class="medicine-search">
          <div class="patient-search-section">
            <input type="hidden" name="patientQuery" value="${param.patientQuery}">
            <input type="text" id="medicine-search-input" class="search-input"
                   placeholder="Type to search medicines by name, type or company..."
                   value="${param.medicineQuery}">
            <button type="button" id="search-medicines-btn" class="btn btn-secondary">
              <i class="fas fa-search"></i> Search Medicines
            </button>
          </div>
          
          <!-- Real-time search results -->
          <div id="medicine-search-results" class="search-results" style="display: none;">
            <div class="search-results-header">
              <h4>Search Results</h4>
              <button type="button" id="close-search-results" class="btn btn-secondary btn-sm">
                <i class="fas fa-times"></i> Close
              </button>
            </div>
            <div id="search-results-list" class="search-results-list">
              <!-- Results will be populated here -->
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Prescription Form -->
    <div class="card">
      <div class="card-header">
        <h2 class="card-title">
          <i class="fas fa-prescription-bottle-medical"></i>
          Patient Information & Prescription
        </h2>
      </div>
      <div class="card-body">
        <form id="prescription-form" action="${pageContext.request.contextPath}/pharmacist/new-prescription" method="post">
          <!-- Hidden field for selected patient ID -->
          <input type="hidden" id="selected-patient-id" name="selectedPatientId">

          <div class="form-grid">
            <div class="form-group">
              <label class="form-label" for="patient-name">Patient Name *</label>
              <input type="text" id="patient-name" name="name" class="form-input"
                     placeholder="Enter full name" required>
            </div>
            <div class="form-group">
              <label class="form-label" for="patient-age">Age</label>
              <input type="number" id="patient-age" name="age" class="form-input"
                     min="0" max="150" placeholder="Enter age">
            </div>
            <div class="form-group">
              <label class="form-label" for="patient-phone">Phone Number</label>
              <input type="text" id="patient-phone" name="phoneNumber" class="form-input"
                     placeholder="Enter 10-digit phone number" maxlength="10" pattern="\d{10}" title="Enter exactly 10 digits">
            </div>
          </div>

          <!-- Medicine Selection -->
          <div class="medicines-section">
            <h3 style="margin-bottom: 1rem; color: var(--gray-700);">Select Medicines</h3>
            <c:choose>
              <c:when test="${not empty allMeds}">
                <div class="table-container">
                  <table class="medicine-table">
                    <thead>
                      <tr>
                        <th>Select</th>
                        <th>Medicine Name</th>
                        <th>Type</th>
                        <th>Company</th>
                        <th>Price (Rs.)</th>
                        <th>Expiry Date</th>
                        <th>Stock</th>
                        <th>Quantity</th>
                        <th>Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="med" items="${allMeds}">
                        <tr class="medicine-row" data-price="${med.price}" data-stock="${med.quantity}">
                          <td>
                            <input type="checkbox" name="medicineIds" value="${med.id}"
                                   class="checkbox medicine-checkbox"
                                   <c:if test="${med.quantity == 0}">disabled</c:if>
                                   onchange="toggleRow(this)">
                          </td>
                          <td><strong>${med.name}</strong></td>
                          <td>${med.type}</td>
                          <td>${med.company}</td>
                          <td>Rs. ${med.price}</td>
                          <td>${med.expiryDate}</td>
                          <td>
                            <span class="stock-badge ${med.quantity == 0 ? 'stock-low' : (med.quantity < 10 ? 'stock-medium' : 'stock-high')}">
                              ${med.quantity} units
                            </span>
                          </td>
                          <td>
                            <input type="number" name="qty_${med.id}" min="1" max="${med.quantity}"
                                   value="1" class="qty-input" data-medicine-id="${med.id}" onchange="calculateTotal()"
                                   <c:if test="${med.quantity == 0}">disabled</c:if>>
                          </td>
                          <td>
                            <button type="button" class="delete-btn" onclick="removeMedicineFromPrescription(this, '${med.id}')">
                              <i class="fas fa-trash"></i> Remove
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
                  <h3>Search for medicines</h3>
                  <p>Use the search above to find medicines for this prescription</p>
                </div>
              </c:otherwise>
            </c:choose>
          </div>

          <!-- Summary Section -->
          <div id="summary-section" class="summary-section" style="display: none;">
            <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
              <div>
                <h3>Prescription Summary</h3>
                <p id="selected-count">0 medicines selected</p>
                <p id="selected-patient-info" style="color: var(--primary-600); margin-top: 0.5rem;"></p>
              </div>
              <div class="total-display" id="total-amount">Rs. 0.00</div>
            </div>
          </div>

          <div style="margin-top: 2rem; text-align: center;">
            <button type="submit" class="btn btn-success btn-lg">
              <i class="fas fa-prescription-bottle-medical"></i>
              Create Prescription
            </button>
          </div>
        </form>
      </div>
    </div>
  </main>

<script>
    // Toast management
    function showToast(element) {
      if (element) {
        setTimeout(function() {
          element.classList.add('hide');
          setTimeout(function() {
            element.remove();
          }, 300);
        }, 4000);
      }
    }

    // Initialize toasts
    showToast(document.getElementById('toast-success'));
    showToast(document.getElementById('toast-error'));

    // Patient selection
    var selectedPatientData = null;

    function selectPatient(userId, name, age, phone, isPremium, points) {
      selectedPatientData = {
        userId: userId,
        name: name,
        age: age,
        phone: phone,
        isPremium: isPremium,
        points: points
      };

      // Update form fields
      document.getElementById('selected-patient-id').value = userId;
      document.getElementById('patient-name').value = name;
      document.getElementById('patient-age').value = age || '';
      document.getElementById('patient-phone').value = phone || '';

      // Make fields read-only when patient is selected
      document.getElementById('patient-name').readOnly = true;
      document.getElementById('patient-age').readOnly = true;
      document.getElementById('patient-phone').readOnly = true;

      // Update visual selection
      var patientCards = document.querySelectorAll('.patient-card');
      for (var i = 0; i < patientCards.length; i++) {
        patientCards[i].classList.remove('selected');
      }
      event.currentTarget.classList.add('selected');

      // Update summary
      updatePatientSummary();

      // Show success message
      showToast(createToast('success', 'Selected patient: ' + name));
    }

    function updatePatientSummary() {
      var summaryInfo = document.getElementById('selected-patient-info');
      if (selectedPatientData) {
        var info = 'Patient: ' + selectedPatientData.name;
        if (selectedPatientData.isPremium) {
          info += ' (Premium Member - ' + selectedPatientData.points + ' points)';
        }
        summaryInfo.textContent = info;
      }
    }

    function createToast(type, message) {
      var toast = document.createElement('div');
      toast.className = 'toast ' + type;

      var iconClass = type === 'success' ? 'check-circle' : 'exclamation-triangle';
      toast.innerHTML = '<i class="fas fa-' + iconClass + '"></i><strong>' + message + '</strong>';

      document.body.appendChild(toast);
      return toast;
    }

    // Patient search functionality
    document.getElementById('search-patient-btn').addEventListener('click', function() {
      var query = document.getElementById('patient-search').value.trim();
      if (query) {
        window.location.href = '${pageContext.request.contextPath}/pharmacist/new-prescription?patientQuery=' + encodeURIComponent(query);
      }
    });

    document.getElementById('patient-search').addEventListener('keypress', function(e) {
      if (e.key === 'Enter') {
        document.getElementById('search-patient-btn').click();
      }
    });

    // Medicine search functionality
    var searchTimeout;
    var selectedMedicines = new Set(); // Track selected medicines to avoid duplicates

    document.getElementById('medicine-search-input').addEventListener('input', function() {
      var query = this.value.trim();
      
      // Clear previous timeout
      if (searchTimeout) {
        clearTimeout(searchTimeout);
      }
      
      // Hide results if query is empty
      if (query.length === 0) {
        document.getElementById('medicine-search-results').style.display = 'none';
        return;
      }
      
      // Debounce search - wait 300ms after user stops typing
      searchTimeout = setTimeout(function() {
        searchMedicines(query);
      }, 300);
    });

    document.getElementById('search-medicines-btn').addEventListener('click', function() {
      var query = document.getElementById('medicine-search-input').value.trim();
      if (query) {
        searchMedicines(query);
      }
    });

    document.getElementById('medicine-search-input').addEventListener('keypress', function(e) {
      if (e.key === 'Enter') {
        e.preventDefault();
        var query = this.value.trim();
        if (query) {
          searchMedicines(query);
        }
      }
    });

    function searchMedicines(query) {
      if (query.length < 2) {
        document.getElementById('medicine-search-results').style.display = 'none';
        return;
      }

      fetch('${pageContext.request.contextPath}/pharmacist/search-medicines-ajax?query=' + encodeURIComponent(query))
        .then(response => response.json())
        .then(medicines => {
          displaySearchResults(medicines);
        })
        .catch(error => {
          console.error('Error searching medicines:', error);
          document.getElementById('search-results-list').innerHTML = '<div class="empty-state"><i class="fas fa-exclamation-triangle"></i><p>Error searching medicines</p></div>';
        });
    }

    function displaySearchResults(medicines) {
      var resultsContainer = document.getElementById('search-results-list');
      var resultsDiv = document.getElementById('medicine-search-results');
      
      if (medicines.length === 0) {
        resultsContainer.innerHTML = '<div class="empty-state"><i class="fas fa-search"></i><p>No medicines found</p></div>';
        resultsDiv.style.display = 'block';
        return;
      }

      var html = '';
      medicines.forEach(function(medicine) {
        var stockClass = medicine.quantity === 0 ? 'low' : (medicine.quantity < 10 ? 'medium' : 'high');
        var isSelected = selectedMedicines.has(medicine.id);
        
        html += '<div class="search-result-item" data-medicine-id="' + medicine.id + '" data-expiry-date="' + (medicine.expiryDate || '') + '">';
        html += '  <div class="search-result-info">';
        html += '    <div class="search-result-name">' + medicine.name + '</div>';
        html += '    <div class="search-result-details">';
        html += '      <span>' + medicine.type + '</span>';
        html += '      <span>' + medicine.company + '</span>';
        html += '      <span class="search-result-price">Rs. ' + medicine.price + '</span>';
        html += '      <span class="search-result-stock ' + stockClass + '">' + medicine.quantity + ' units</span>';
        html += '    </div>';
        html += '  </div>';
        html += '  <div class="search-result-actions">';
        if (isSelected) {
          html += '    <button type="button" class="btn btn-secondary btn-sm" disabled>';
          html += '      <i class="fas fa-check"></i> Added';
          html += '    </button>';
        } else if (medicine.quantity === 0) {
          html += '    <button type="button" class="btn btn-secondary btn-sm" disabled>';
          html += '      <i class="fas fa-times"></i> Out of Stock';
          html += '    </button>';
        } else {
          html += '    <button type="button" class="btn btn-primary btn-sm add-medicine-btn">';
          html += '      <i class="fas fa-plus"></i> Add to Prescription';
          html += '    </button>';
        }
        html += '  </div>';
        html += '</div>';
      });
      
      resultsContainer.innerHTML = html;
      resultsDiv.style.display = 'block';
      
      // Add event listeners to add buttons
      var addButtons = resultsContainer.querySelectorAll('.add-medicine-btn');
      addButtons.forEach(function(button) {
        button.addEventListener('click', function() {
          var medicineItem = this.closest('.search-result-item');
          var medicineId = medicineItem.dataset.medicineId;
          addMedicineToPrescription(medicineId, medicineItem);
        });
      });
    }

    function addMedicineToPrescription(medicineId, medicineElement) {
      // Find the medicine data from the search results
      var medicineName = medicineElement.querySelector('.search-result-name').textContent;
      var medicinePrice = medicineElement.querySelector('.search-result-price').textContent.replace('Rs. ', '');
      var medicineStock = medicineElement.querySelector('.search-result-stock').textContent.replace(' units', '');
      var medicineType = medicineElement.querySelector('.search-result-details span:first-child').textContent;
      var medicineCompany = medicineElement.querySelector('.search-result-details span:nth-child(2)').textContent;
      var medicineExpiryDate = medicineElement.dataset.expiryDate || 'N/A';
      
      // Check if already selected
      if (selectedMedicines.has(medicineId)) {
        return;
      }
      
      // Add to selected medicines
      selectedMedicines.add(medicineId);
      
      // Add to prescription table
      addMedicineToTable({
        id: medicineId,
        name: medicineName,
        price: parseFloat(medicinePrice),
        quantity: parseInt(medicineStock),
        type: medicineType,
        company: medicineCompany,
        expiryDate: medicineExpiryDate
      });
      
      // Update the search result button
      var button = medicineElement.querySelector('.add-medicine-btn');
      button.innerHTML = '<i class="fas fa-check"></i> Added';
      button.classList.remove('btn-primary');
      button.classList.add('btn-secondary');
      button.disabled = true;
      
      // Show success message
      showToast(createToast('success', 'Added ' + medicineName + ' to prescription'));
    }

    function addMedicineToTable(medicine) {
      var tableBody = document.querySelector('.medicine-table tbody');
      if (!tableBody) {
        // Create table if it doesn't exist
        createMedicineTable();
        tableBody = document.querySelector('.medicine-table tbody');
      }
      
      var row = document.createElement('tr');
      row.className = 'medicine-row selected';
      row.setAttribute('data-price', medicine.price);
      row.setAttribute('data-stock', medicine.quantity);
      
      var stockClass = medicine.quantity === 0 ? 'stock-low' : (medicine.quantity < 10 ? 'stock-medium' : 'stock-high');
      
      row.innerHTML = 
        '<td>' +
          '<input type="checkbox" name="medicineIds" value="' + medicine.id + '" class="checkbox medicine-checkbox" checked onchange="toggleRow(this)">' +
        '</td>' +
        '<td><strong>' + medicine.name + '</strong></td>' +
        '<td>' + medicine.type + '</td>' +
        '<td>' + medicine.company + '</td>' +
        '<td>Rs. ' + medicine.price + '</td>' +
        '<td>' + (medicine.expiryDate || 'N/A') + '</td>' +
        '<td>' +
          '<span class="stock-badge ' + stockClass + '">' + medicine.quantity + ' units</span>' +
        '</td>' +
        '<td>' +
          '<input type="number" name="qty_' + medicine.id + '" min="1" max="' + medicine.quantity + '" value="1" class="qty-input" data-medicine-id="' + medicine.id + '" onchange="calculateTotal()">' +
        '</td>' +
        '<td>' +
          '<button type="button" class="delete-btn" onclick="removeMedicineFromPrescription(this, \'' + medicine.id + '\')">' +
            '<i class="fas fa-trash"></i> Remove' +
          '</button>' +
        '</td>';
      
      tableBody.appendChild(row);
      
      // Recalculate total
      calculateTotal();
    }

    function createMedicineTable() {
      var medicinesSection = document.querySelector('.medicines-section');
      var existingTable = medicinesSection.querySelector('.table-container');
      
      if (!existingTable) {
        var tableHtml = 
          '<div class="table-container">' +
            '<table class="medicine-table">' +
              '<thead>' +
                '<tr>' +
                  '<th>Select</th>' +
                  '<th>Medicine Name</th>' +
                  '<th>Type</th>' +
                  '<th>Company</th>' +
                  '<th>Price (Rs.)</th>' +
                  '<th>Expiry Date</th>' +
                  '<th>Stock</th>' +
                  '<th>Quantity</th>' +
                '</tr>' +
              '</thead>' +
              '<tbody></tbody>' +
            '</table>' +
          '</div>';
        
        medicinesSection.innerHTML = '<h3 style="margin-bottom: 1rem; color: var(--gray-700);">Selected Medicines</h3>' + tableHtml;
      }
    }

    // Close search results
    document.getElementById('close-search-results').addEventListener('click', function() {
      document.getElementById('medicine-search-results').style.display = 'none';
    });

    // Remove medicine from prescription
    function removeMedicineFromPrescription(button, medicineId) {
      // Get medicine name for confirmation
      var row = button.closest('tr');
      var medicineName = row.querySelector('td:nth-child(2) strong').textContent;
      
      // Show confirmation dialog
      if (confirm('Are you sure you want to remove "' + medicineName + '" from the prescription?')) {
        // Remove from selected medicines set
        selectedMedicines.delete(medicineId);
        
        // Remove the row from table
        row.remove();
        
        // Recalculate total
        calculateTotal();
        
        // Show success message
        showToast(createToast('success', 'Removed ' + medicineName + ' from prescription'));
        
        // Check if table is now empty and hide summary
        var tableBody = document.querySelector('.medicine-table tbody');
        if (tableBody && tableBody.children.length === 0) {
          document.getElementById('summary-section').style.display = 'none';
        }
      }
    }

    // New patient button
    document.getElementById('new-patient-btn').addEventListener('click', function() {
      // Clear selected patient
      selectedPatientData = null;
      document.getElementById('selected-patient-id').value = '';

      // Clear and enable form fields
      document.getElementById('patient-name').value = '';
      document.getElementById('patient-age').value = '';
      document.getElementById('patient-phone').value = '';
      document.getElementById('patient-name').readOnly = false;
      document.getElementById('patient-age').readOnly = false;
      document.getElementById('patient-phone').readOnly = false;

      // Clear visual selection
      var patientCards = document.querySelectorAll('.patient-card');
      for (var i = 0; i < patientCards.length; i++) {
        patientCards[i].classList.remove('selected');
      }

      // Show create new patient section
      document.getElementById('create-new-patient').style.display = 'block';

      // Update summary
      document.getElementById('selected-patient-info').textContent = '';

      // Focus on name field
      document.getElementById('patient-name').focus();
    });

    // Row selection and calculation
    function toggleRow(checkbox) {
      var row = checkbox.closest('tr');
      if (checkbox.checked) {
        row.classList.add('selected');
      } else {
        row.classList.remove('selected');
      }
      calculateTotal();
    }

    function calculateTotal() {
      var checkboxes = document.querySelectorAll('.medicine-checkbox:checked');
      var summarySection = document.getElementById('summary-section');
      var totalAmount = document.getElementById('total-amount');
      var selectedCount = document.getElementById('selected-count');

      var total = 0;
      var count = 0;

      for (var i = 0; i < checkboxes.length; i++) {
        var checkbox = checkboxes[i];
        var row = checkbox.closest('tr');
        var price = parseFloat(row.dataset.price);
        var medicineId = checkbox.value;
        var qtyInput = document.querySelector('input[name="qty_' + medicineId + '"]');
        var qty = parseInt(qtyInput.value) || 0;

        total += price * qty;
        count++;
      }

      if (count > 0) {
        summarySection.style.display = 'block';
        totalAmount.textContent = 'Rs. ' + total.toFixed(2);
        selectedCount.textContent = count + ' medicine' + (count > 1 ? 's' : '') + ' selected';
        updatePatientSummary();
      } else {
        summarySection.style.display = 'none';
      }
    }

    // Form validation and data preparation
    document.getElementById('prescription-form').addEventListener('submit', function(e) {
      var checkboxes = document.querySelectorAll('.medicine-checkbox:checked');
      var patientName = document.getElementById('patient-name').value.trim();

      if (!patientName) {
        e.preventDefault();
        alert('Please enter patient name.');
        return;
      }

      if (checkboxes.length === 0) {
        e.preventDefault();
        alert('Please select at least one medicine for the prescription.');
        return;
      }

      // Prepare medicine data for submission
      var medicineIds = [];
      var quantities = [];
      var processedMedicines = new Set(); // Track processed medicines to avoid duplicates
      
      // Process all checked medicines
      for (var i = 0; i < checkboxes.length; i++) {
        var checkbox = checkboxes[i];
        var medicineId = checkbox.value;
        
        // Skip if already processed
        if (processedMedicines.has(medicineId)) {
          continue;
        }
        
        var qtyInput = document.querySelector('input[name="qty_' + medicineId + '"]');
        var quantity = parseInt(qtyInput.value) || 0;
        
        if (quantity > 0) {
          medicineIds.push(medicineId);
          quantities.push(quantity);
          processedMedicines.add(medicineId);
        }
      }

      // Add hidden inputs for the arrays
      var form = this;
      
      // Remove any existing hidden inputs
      var existingInputs = form.querySelectorAll('input[name="medicineIds[]"], input[name="qty[]"]');
      for (var j = 0; j < existingInputs.length; j++) {
        existingInputs[j].remove();
      }
      
      // Add new hidden inputs for medicine IDs
      for (var k = 0; k < medicineIds.length; k++) {
        var medicineIdInput = document.createElement('input');
        medicineIdInput.type = 'hidden';
        medicineIdInput.name = 'medicineIds';
        medicineIdInput.value = medicineIds[k];
        form.appendChild(medicineIdInput);
      }
      
      // Add new hidden inputs for quantities
      for (var l = 0; l < quantities.length; l++) {
        var qtyInput = document.createElement('input');
        qtyInput.type = 'hidden';
        qtyInput.name = 'qty';
        qtyInput.value = quantities[l];
        form.appendChild(qtyInput);
      }
      
      // Debug logging removed - validation no longer needed
    });

    // Auto-select checkbox when quantity is changed
    var qtyInputs = document.querySelectorAll('.qty-input');
    for (var i = 0; i < qtyInputs.length; i++) {
      qtyInputs[i].addEventListener('input', function() {
        var checkbox = this.closest('tr').querySelector('.medicine-checkbox');
        if (this.value > 0 && !checkbox.disabled) {
          checkbox.checked = true;
          toggleRow(checkbox);
        }
      });
    }

    // Initialize page
    document.addEventListener('DOMContentLoaded', function() {
      // If there are medicines, calculate initial total
      calculateTotal();
      
      // Mark existing medicines as selected to prevent duplicates
      var existingCheckboxes = document.querySelectorAll('.medicine-checkbox:checked');
      existingCheckboxes.forEach(function(checkbox) {
        selectedMedicines.add(checkbox.value);
      });
    });
</script>

</body>
</html>
