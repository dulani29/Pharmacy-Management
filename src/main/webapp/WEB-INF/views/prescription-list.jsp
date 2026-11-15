<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title>All Prescriptions • PharmaCare</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

  <style>
    :root {
      --primary-500: #4f46e5;
      --primary-600: #4338ca;
      --primary-700: #3730a3;
      --primary-50: #eef2ff;
      --primary-100: #e0e7ff;

      --green-50: #f0fdf4;
      --green-100: #dcfce7;
      --green-500: #22c55e;
      --green-600: #16a34a;

      --blue-50: #eff6ff;
      --blue-100: #dbeafe;
      --blue-500: #3b82f6;
      --blue-600: #2563eb;

      --yellow-50: #fffbeb;
      --yellow-100: #fef3c7;
      --yellow-500: #f59e0b;
      --yellow-600: #d97706;

      --red-50: #fef2f2;
      --red-100: #fee2e2;
      --red-500: #ef4444;
      --red-600: #dc2626;

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
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    body {
      font-family: 'Inter', system-ui, -apple-system, sans-serif;
      background: var(--gray-50);
      color: var(--gray-900);
      line-height: 1.6;
    }

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
      max-width: 1400px;
      margin: 0 auto;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 2rem;
    }

    .logo {
      font-size: 1.5rem;
      font-weight: 800;
      color: var(--primary-600);
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .nav-links {
      display: flex;
      gap: 2rem;
    }

    .nav-links a {
      color: var(--gray-600);
      text-decoration: none;
      font-weight: 500;
      padding: 0.75rem 1.25rem;
      border-radius: var(--radius-lg);
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .nav-links a:hover {
      background: var(--primary-50);
      color: var(--primary-600);
      transform: translateY(-2px);
    }

    .nav-links a.active {
      background: var(--primary-100);
      color: var(--primary-700);
      font-weight: 600;
    }

    .main-container {
      max-width: 1400px;
      margin: 0 auto;
      padding: 2rem;
    }

    .page-header {
      background: white;
      border-radius: var(--radius-2xl);
      padding: 2rem;
      box-shadow: var(--shadow-lg);
      border: 1px solid var(--gray-200);
      margin-bottom: 2rem;
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
      background: linear-gradient(90deg, var(--primary-500), var(--blue-500));
    }

    .header-content {
      display: flex;
      justify-content: space-between;
      align-items: center;
      gap: 2rem;
      flex-wrap: wrap;
    }

    .header-info h1 {
      font-size: 2.25rem;
      font-weight: 800;
      color: var(--gray-900);
      margin-bottom: 0.5rem;
      display: flex;
      align-items: center;
      gap: 0.75rem;
    }

    .header-subtitle {
      color: var(--gray-600);
      font-size: 1.125rem;
    }

    .header-actions {
      display: flex;
      gap: 1rem;
      align-items: center;
    }

    .stats-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 1.5rem;
      margin-bottom: 2rem;
    }

    .stat-card {
      background: white;
      border-radius: var(--radius-xl);
      padding: 1.5rem;
      box-shadow: var(--shadow-md);
      border: 1px solid var(--gray-200);
      transition: all 0.3s ease;
    }

    .stat-card:hover {
      transform: translateY(-4px);
      box-shadow: var(--shadow-xl);
    }

    .stat-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1rem;
    }

    .stat-title {
      font-size: 0.875rem;
      font-weight: 600;
      color: var(--gray-600);
      text-transform: uppercase;
      letter-spacing: 0.05em;
    }

    .stat-icon {
      width: 40px;
      height: 40px;
      border-radius: var(--radius-lg);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.125rem;
      color: white;
    }

    .stat-icon.pending { background: linear-gradient(135deg, var(--yellow-500), var(--yellow-600)); }
    .stat-icon.completed { background: linear-gradient(135deg, var(--green-500), var(--green-600)); }
    .stat-icon.payment { background: linear-gradient(135deg, var(--blue-500), var(--blue-600)); }
    .stat-icon.total { background: linear-gradient(135deg, var(--primary-500), var(--primary-600)); }

    .stat-value {
      font-size: 2rem;
      font-weight: 800;
      color: var(--gray-900);
    }

    .filters-section {
      background: white;
      border-radius: var(--radius-xl);
      padding: 1.5rem;
      box-shadow: var(--shadow-md);
      border: 1px solid var(--gray-200);
      margin-bottom: 2rem;
    }

    .filters-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1.5rem;
    }

    .filters-title {
      font-size: 1.125rem;
      font-weight: 600;
      color: var(--gray-900);
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .filters-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 1rem;
      align-items: end;
    }

    .filter-group {
      display: flex;
      flex-direction: column;
    }

    .filter-label {
      font-size: 0.875rem;
      font-weight: 500;
      color: var(--gray-700);
      margin-bottom: 0.5rem;
    }

    .filter-input, .filter-select {
      padding: 0.75rem 1rem;
      border: 2px solid var(--gray-300);
      border-radius: var(--radius-lg);
      font-size: 1rem;
      transition: all 0.3s ease;
      background: white;
    }

    .filter-input:focus, .filter-select:focus {
      outline: none;
      border-color: var(--primary-500);
      box-shadow: 0 0 0 3px rgb(79 70 229 / 0.1);
    }

    .btn {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
      padding: 0.75rem 1.5rem;
      border: none;
      border-radius: var(--radius-lg);
      font-weight: 600;
      font-size: 0.875rem;
      cursor: pointer;
      transition: all 0.3s ease;
      text-decoration: none;
      white-space: nowrap;
    }

    .btn-primary {
      background: linear-gradient(135deg, var(--primary-500), var(--primary-600));
      color: white;
      box-shadow: var(--shadow-sm);
    }

    .btn-primary:hover {
      background: linear-gradient(135deg, var(--primary-600), var(--primary-700));
      transform: translateY(-2px);
      box-shadow: var(--shadow-lg);
    }

    .prescriptions-container {
      background: white;
      border-radius: var(--radius-xl);
      box-shadow: var(--shadow-lg);
      border: 1px solid var(--gray-200);
      overflow: hidden;
    }

    .container-header {
      padding: 1.5rem 2rem;
      border-bottom: 1px solid var(--gray-200);
      background: var(--gray-50);
    }

    .container-title {
      font-size: 1.25rem;
      font-weight: 700;
      color: var(--gray-900);
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .prescriptions-list {
      max-height: 800px;
      overflow-y: auto;
    }

    .prescription-group {
      border-bottom: 1px solid var(--gray-100);
    }

    .prescription-group:last-child {
      border-bottom: none;
    }

    .patient-header {
      background: linear-gradient(135deg, var(--primary-50), var(--blue-50));
      padding: 1.5rem 2rem;
      border-left: 4px solid var(--primary-500);
      display: flex;
      justify-content: space-between;
      align-items: center;
      gap: 1rem;
    }

    .patient-info {
      display: flex;
      align-items: center;
      gap: 1rem;
    }

    .patient-avatar {
      width: 48px;
      height: 48px;
      background: linear-gradient(135deg, var(--primary-500), var(--primary-600));
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-weight: 700;
      font-size: 1.125rem;
    }

    .patient-details h3 {
      font-size: 1.25rem;
      font-weight: 700;
      color: var(--gray-900);
      margin-bottom: 0.25rem;
    }

    .patient-meta {
      font-size: 0.875rem;
      color: var(--gray-600);
      display: flex;
      gap: 1rem;
    }

    .patient-stats {
      display: flex;
      gap: 2rem;
      align-items: center;
    }

    .patient-stat {
      text-align: center;
    }

    .patient-stat-value {
      font-size: 1.5rem;
      font-weight: 700;
      color: var(--primary-600);
      line-height: 1;
    }

    .patient-stat-label {
      font-size: 0.75rem;
      color: var(--gray-500);
      text-transform: uppercase;
      letter-spacing: 0.05em;
      font-weight: 500;
    }

    .medicines-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 1rem;
      padding: 1.5rem 2rem;
      background: var(--gray-50);
    }

    .medicine-card {
      background: white;
      border-radius: var(--radius-lg);
      padding: 1.5rem;
      border: 2px solid var(--gray-200);
      transition: all 0.3s ease;
      position: relative;
    }

    .medicine-card:hover {
      border-color: var(--primary-300);
      transform: translateY(-2px);
      box-shadow: var(--shadow-md);
    }

    .medicine-header {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      margin-bottom: 1rem;
    }

    .medicine-name {
      font-size: 1.125rem;
      font-weight: 700;
      color: var(--gray-900);
      margin-bottom: 0.25rem;
    }

    .medicine-type {
      font-size: 0.875rem;
      color: var(--gray-600);
    }

    .status-badge {
      padding: 0.375rem 0.875rem;
      border-radius: 9999px;
      font-size: 0.75rem;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 0.05em;
    }

    .status-pending {
      background: var(--yellow-100);
      color: var(--yellow-600);
    }

    .status-completed {
      background: var(--green-100);
      color: var(--green-600);
    }

    .status-payment-pending {
      background: var(--blue-100);
      color: var(--blue-600);
    }

    .medicine-details {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 1rem;
      margin-top: 1rem;
    }

    .medicine-detail {
      display: flex;
      flex-direction: column;
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
      font-size: 0.875rem;
      font-weight: 600;
      color: var(--gray-900);
    }

    .price-value {
      color: var(--primary-600);
      font-size: 1rem;
    }

    .premium-badge {
      position: absolute;
      top: -8px;
      right: -8px;
      background: linear-gradient(135deg, #f59e0b, #d97706);
      color: white;
      padding: 0.375rem 0.75rem;
      border-radius: 9999px;
      font-size: 0.75rem;
      font-weight: 700;
      display: flex;
      align-items: center;
      gap: 0.25rem;
      box-shadow: var(--shadow-md);
    }

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
      color: var(--gray-400);
      margin: 0 auto 1.5rem;
    }

    .empty-title {
      font-size: 1.5rem;
      font-weight: 700;
      color: var(--gray-700);
      margin-bottom: 0.5rem;
    }

    .empty-message {
      font-size: 1rem;
      color: var(--gray-500);
      margin-bottom: 2rem;
    }

    @media (max-width: 1024px) {
      .nav-links {
        gap: 1rem;
      }

      .header-content {
        flex-direction: column;
        align-items: flex-start;
      }

      .patient-stats {
        gap: 1rem;
      }
    }

    @media (max-width: 768px) {
      .main-container {
        padding: 1rem;
      }

      .nav-container {
        padding: 0 1rem;
        flex-direction: column;
        gap: 1rem;
      }

      .nav-links {
        flex-wrap: wrap;
        justify-content: center;
      }

      .stats-grid {
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      }

      .filters-grid {
        grid-template-columns: 1fr;
      }

      .medicines-grid {
        grid-template-columns: 1fr;
      }

      .patient-header {
        flex-direction: column;
        align-items: flex-start;
      }

      .patient-stats {
        align-self: stretch;
        justify-content: space-around;
      }
    }

    @media (max-width: 480px) {
      .page-header {
        padding: 1.5rem;
      }

      .container-header, .patient-header, .medicines-grid {
        padding: 1rem;
      }

      .patient-meta {
        flex-direction: column;
        gap: 0.25rem;
      }
    }
  </style>
</head>
<body>

  <header class="header">
    <div class="nav-container">
      <div class="logo">
        <i class="fas fa-pills"></i>
        PharmaCare
      </div>
      <nav class="nav-links">
        <a href="${pageContext.request.contextPath}/pharmacist-dashboard">
          <i class="fas fa-home"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/pharmacist/new-prescription">
          <i class="fas fa-plus-circle"></i> New Prescription
        </a>
        <a href="${pageContext.request.contextPath}/pharmacist/prescriptions" class="active">
          <i class="fas fa-list-alt"></i> All Prescriptions
        </a>
        <a href="${pageContext.request.contextPath}/logout">
          <i class="fas fa-sign-out-alt"></i> Logout
        </a>
      </nav>
    </div>
  </header>

  <main class="main-container">
    <div class="page-header">
      <div class="header-content">
        <div class="header-info">
          <h1>
            <i class="fas fa-prescription-bottle-medical"></i>
            All Prescriptions
          </h1>
          <p class="header-subtitle">Manage and track all patient prescriptions</p>
        </div>
        <div class="header-actions">
          <a href="${pageContext.request.contextPath}/pharmacist/new-prescription" class="btn btn-primary">
            <i class="fas fa-plus"></i> New Prescription
          </a>
        </div>
      </div>
    </div>

    <div class="stats-grid">
      <div class="stat-card">
        <div class="stat-header">
          <div class="stat-title">Total Prescriptions</div>
          <div class="stat-icon total">
            <i class="fas fa-prescription-bottle"></i>
          </div>
        </div>
        <div class="stat-value">
          <c:set var="totalCount" value="0" />
          <c:forEach var="p" items="${prescriptions}">
            <c:set var="totalCount" value="${totalCount + 1}" />
          </c:forEach>
          ${totalCount}
        </div>
      </div>

      <div class="stat-card">
        <div class="stat-header">
          <div class="stat-title">Payment Pending</div>
          <div class="stat-icon payment">
            <i class="fas fa-clock"></i>
          </div>
        </div>
        <div class="stat-value">
          <c:set var="pendingCount" value="0" />
          <c:forEach var="p" items="${prescriptions}">
            <c:if test="${p.status == 'PAYMENT_PENDING'}">
              <c:set var="pendingCount" value="${pendingCount + 1}" />
            </c:if>
          </c:forEach>
          ${pendingCount}
        </div>
      </div>

      <div class="stat-card">
        <div class="stat-header">
          <div class="stat-title">Completed</div>
          <div class="stat-icon completed">
            <i class="fas fa-check-circle"></i>
          </div>
        </div>
        <div class="stat-value">
          <c:set var="completedCount" value="0" />
          <c:forEach var="p" items="${prescriptions}">
            <c:if test="${p.status == 'COMPLETED'}">
              <c:set var="completedCount" value="${completedCount + 1}" />
            </c:if>
          </c:forEach>
          ${completedCount}
        </div>
      </div>

      <div class="stat-card">
        <div class="stat-header">
          <div class="stat-title">Unique Patients</div>
          <div class="stat-icon pending">
            <i class="fas fa-users"></i>
          </div>
        </div>
        <div class="stat-value">
          <c:set var="uniquePatients" value="" />
          <c:forEach var="p" items="${prescriptions}">
            <c:if test="${not fn:contains(uniquePatients, p.patient.userId)}">
              <c:set var="uniquePatients" value="${uniquePatients},${p.patient.userId}" />
            </c:if>
          </c:forEach>
          <c:set var="patientCount" value="${fn:length(fn:split(uniquePatients, ',')) - 1}" />
          ${patientCount > 0 ? patientCount : 0}
        </div>
      </div>
    </div>

    <div class="filters-section">
      <div class="filters-header">
        <h2 class="filters-title">
          <i class="fas fa-filter"></i>
          Filter & Search
        </h2>
      </div>
      <form class="filters-grid" method="get">
        <div class="filter-group">
          <label class="filter-label">Search Patient</label>
          <input type="text" name="patientSearch" class="filter-input"
                 placeholder="Patient name or ID..."
                 value="${param.patientSearch}">
        </div>
        <div class="filter-group">
          <label class="filter-label">Status</label>
          <select name="statusFilter" class="filter-select">
            <option value="">All Statuses</option>
            <option value="PAYMENT_PENDING" ${param.statusFilter == 'PAYMENT_PENDING' ? 'selected' : ''}>Payment Pending</option>
            <option value="COMPLETED" ${param.statusFilter == 'COMPLETED' ? 'selected' : ''}>Completed</option>
            <option value="CANCELLED" ${param.statusFilter == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
          </select>
        </div>
        <div class="filter-group">
          <label class="filter-label">Medicine Type</label>
          <input type="text" name="medicineType" class="filter-input"
                 placeholder="e.g., Tablet, Syrup..."
                 value="${param.medicineType}">
        </div>
        <div class="filter-group" style="align-self: end;">
          <button type="submit" class="btn btn-primary">
            <i class="fas fa-search"></i> Search
          </button>
        </div>
      </form>
    </div>

    <div class="prescriptions-container">
      <div class="container-header">
        <h2 class="container-title">
          <i class="fas fa-list"></i>
          Prescription Records
        </h2>
      </div>

      <c:choose>
        <c:when test="${empty prescriptions}">
          <div class="empty-state">
            <div class="empty-icon">
              <i class="fas fa-prescription-bottle"></i>
            </div>
            <h3 class="empty-title">No Prescriptions Found</h3>
            <p class="empty-message">
              No prescriptions have been created yet. Start by creating a new prescription for a patient.
            </p>
            <a href="${pageContext.request.contextPath}/pharmacist/new-prescription" class="btn btn-primary">
              <i class="fas fa-plus"></i> Create First Prescription
            </a>
          </div>
        </c:when>
        <c:otherwise>
          <div class="prescriptions-list">
            <c:set var="currentPatient" value="" />

            <c:forEach var="prescription" items="${prescriptions}" varStatus="status">
              <c:if test="${prescription.patient.userId != currentPatient}">
                <c:if test="${not empty currentPatient}">
                      </div>
                    </div>
                </c:if>

                <div class="prescription-group">
                  <div class="patient-header">
                    <div class="patient-info">
                      <div class="patient-avatar">
                        ${fn:substring(prescription.patient.name, 0, 1)}
                      </div>
                      <div class="patient-details">
                        <h3>${prescription.patient.name}</h3>
                        <div class="patient-meta">
                          <span><i class="fas fa-id-card"></i> ID: ${prescription.patient.userId}</span>
                          <span><i class="fas fa-birthday-cake"></i> Age: ${prescription.patient.age != null ? prescription.patient.age : 'N/A'}</span>
                          <c:if test="${not empty prescription.patient.phoneNumber}">
                            <span><i class="fas fa-phone"></i> ${prescription.patient.phoneNumber}</span>
                          </c:if>
                        </div>
                      </div>
                    </div>
                    <div class="patient-stats">
                      <div class="patient-stat">
                        <div class="patient-stat-value">
                          <c:set var="patientMedicineCount" value="0" />
                          <c:forEach var="p" items="${prescriptions}">
                            <c:if test="${p.patient.userId == prescription.patient.userId}">
                              <c:set var="patientMedicineCount" value="${patientMedicineCount + 1}" />
                            </c:if>
                          </c:forEach>
                          ${patientMedicineCount}
                        </div>
                        <div class="patient-stat-label">Medicines</div>
                      </div>
                      <c:if test="${prescription.patient.premiumMember}">
                        <div class="premium-badge">
                          <i class="fas fa-crown"></i> Premium
                        </div>
                      </c:if>
                    </div>
                  </div>
                  <div class="medicines-grid">
                <c:set var="currentPatient" value="${prescription.patient.userId}" />
              </c:if>

              <div class="medicine-card">
                <div class="medicine-header">
                  <div>
                    <div class="medicine-name">${prescription.medicine.name}</div>
                    <div class="medicine-type">${prescription.medicine.type}</div>
                  </div>
                  <div class="status-badge status-${fn:toLowerCase(fn:replace(prescription.status, '_', '-'))}">
                    ${prescription.status}
                  </div>
                </div>

                <div class="medicine-details">
                  <div class="medicine-detail">
                    <div class="detail-label">Company</div>
                    <div class="detail-value">${prescription.medicine.company}</div>
                  </div>
                  <div class="medicine-detail">
                    <div class="detail-label">Price</div>
                    <div class="detail-value price-value">Rs. ${prescription.medicine.price}</div>
                  </div>
                  <div class="medicine-detail">
                    <div class="detail-label">Quantity</div>
                    <div class="detail-value">${prescription.qty} units</div>
                  </div>
                  <div class="medicine-detail">
                    <div class="detail-label">Total</div>
                    <div class="detail-value price-value">
                      Rs. ${prescription.medicine.price * prescription.qty}
                    </div>
                  </div>
                </div>
              </div>

              <c:if test="${status.last}">
                    </div>
                  </div>
              </c:if>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </main>

  <script>
    document.querySelectorAll('.filter-select').forEach(function(select) {
      select.addEventListener('change', function() {
        this.form.submit();
      });
    });

    document.addEventListener('DOMContentLoaded', function() {
      var cards = document.querySelectorAll('.medicine-card, .stat-card');
      var observer = new IntersectionObserver(function(entries) {
        entries.forEach(function(entry) {
          if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
          }
        });
      }, { threshold: 0.1 });

      cards.forEach(function(card) {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        card.style.transition = 'all 0.6s ease';
        observer.observe(card);
      });
    });

    var searchInput = document.querySelector('input[name="patientSearch"]');
    var searchTimeout;

    if (searchInput) {
      searchInput.addEventListener('input', function() {
        clearTimeout(searchTimeout);
        var self = this;
        searchTimeout = setTimeout(function() {
          if (self.value.length > 2 || self.value.length === 0) {
            self.form.submit();
          }
        }, 500);
      });
    }
  </script>

</body>
</html>
