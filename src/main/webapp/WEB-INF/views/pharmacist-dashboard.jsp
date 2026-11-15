<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title>Pharmacist Dashboard – PharmaCare</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

  <!-- [Keep all the CSS styles from the previous version] -->
  <style>
    :root {
      --primary-500: #3b82f6;
      --primary-600: #2563eb;
      --primary-700: #1d4ed8;
      --primary-50: #eff6ff;
      --primary-100: #dbeafe;

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

      --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
      --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1);
      --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1);
      --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1);

      --radius-sm: 6px;
      --radius-md: 8px;
      --radius-lg: 12px;
      --radius-xl: 16px;
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
      background: linear-gradient(135deg, var(--primary-600) 0%, var(--primary-700) 100%);
      color: white;
      position: sticky;
      top: 0;
      z-index: 50;
      box-shadow: var(--shadow-lg);
    }

    .header-container {
      max-width: 1280px;
      margin: 0 auto;
      padding: 1.5rem 2rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-wrap: wrap;
      gap: 1rem;
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
    }

    .brand-text h1 {
      font-size: 1.75rem;
      font-weight: 700;
      margin-bottom: 0.25rem;
    }

    .brand-text p {
      font-size: 0.875rem;
      opacity: 0.9;
    }

    .user-info {
      text-align: right;
    }

    .user-name {
      font-size: 1.125rem;
      font-weight: 600;
      margin-bottom: 0.25rem;
    }

    .user-role {
      font-size: 0.875rem;
      opacity: 0.8;
      display: flex;
      align-items: center;
      gap: 0.5rem;
      justify-content: flex-end;
    }

    /* Main Content */
    .main-container {
      max-width: 1280px;
      margin: 0 auto;
      padding: 2rem;
    }

    /* Stats Overview */
    .stats-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 1.5rem;
      margin-bottom: 3rem;
    }

    .stat-card {
      background: white;
      border-radius: var(--radius-xl);
      padding: 2rem;
      box-shadow: var(--shadow-md);
      border: 1px solid var(--gray-200);
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
    }

    .stat-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 4px;
      background: linear-gradient(90deg, var(--primary-500), var(--primary-600));
    }

    .stat-card:hover {
      transform: translateY(-4px);
      box-shadow: var(--shadow-xl);
    }

    .stat-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 1rem;
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
    }

    .stat-icon.pending { background: linear-gradient(135deg, var(--warning-500), var(--warning-600)); }
    .stat-icon.completed { background: linear-gradient(135deg, var(--success-500), var(--success-600)); }
    .stat-icon.inventory { background: linear-gradient(135deg, var(--info-500), var(--info-600)); }

    .stat-number {
      font-size: 2.25rem;
      font-weight: 700;
      color: var(--gray-900);
      margin-bottom: 0.5rem;
    }

    .stat-label {
      font-size: 0.875rem;
      color: var(--gray-600);
      font-weight: 500;
    }

    /* Main Content Grid */
    .content-grid {
      display: grid;
      grid-template-columns: 2fr 1fr;
      gap: 2rem;
    }

    /* Card Styles */
    .card {
      background: white;
      border-radius: var(--radius-xl);
      border: 1px solid var(--gray-200);
      box-shadow: var(--shadow-md);
      overflow: hidden;
      transition: all 0.3s ease;
    }

    .card:hover {
      box-shadow: var(--shadow-lg);
    }

    .card-header {
      padding: 1.5rem 2rem;
      border-bottom: 1px solid var(--gray-200);
      background: var(--gray-50);
    }

    .card-title {
      display: flex;
      align-items: center;
      gap: 0.75rem;
      font-size: 1.25rem;
      font-weight: 600;
      color: var(--gray-900);
    }

    .card-body {
      padding: 2rem;
    }

    /* Prescription List */
    .prescription-list {
      max-height: 500px;
      overflow-y: auto;
      scrollbar-width: thin;
      scrollbar-color: var(--gray-300) var(--gray-100);
    }

    .prescription-list::-webkit-scrollbar {
      width: 6px;
    }

    .prescription-list::-webkit-scrollbar-track {
      background: var(--gray-100);
      border-radius: 3px;
    }

    .prescription-list::-webkit-scrollbar-thumb {
      background: var(--gray-300);
      border-radius: 3px;
    }

    .prescription-item {
      background: var(--gray-50);
      border: 1px solid var(--gray-200);
      border-radius: var(--radius-lg);
      padding: 1.5rem;
      margin-bottom: 1rem;
      cursor: pointer;
      transition: all 0.3s ease;
      position: relative;
    }

    .prescription-item::before {
      content: '';
      position: absolute;
      left: 0;
      top: 0;
      bottom: 0;
      width: 4px;
      background: var(--warning-500);
      border-radius: 0 4px 4px 0;
    }

    .prescription-item:hover {
      background: white;
      border-color: var(--primary-300);
      transform: translateX(4px);
      box-shadow: var(--shadow-md);
    }

    .prescription-header {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      margin-bottom: 1rem;
    }

    .patient-info h4 {
      font-size: 1.125rem;
      font-weight: 600;
      color: var(--gray-900);
      margin-bottom: 0.25rem;
    }

    .patient-meta {
      font-size: 0.875rem;
      color: var(--gray-600);
    }

    .status-badge {
      padding: 0.375rem 0.75rem;
      border-radius: 9999px;
      font-size: 0.75rem;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.05em;
    }

    .status-pending {
      background: var(--warning-50);
      color: var(--warning-600);
      border: 1px solid var(--warning-200);
    }

    .medicine-summary {
      font-size: 0.875rem;
      color: var(--gray-600);
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    /* Quick Actions */
    .actions-grid {
      display: grid;
      gap: 1rem;
    }

    .action-btn {
      display: flex;
      align-items: center;
      gap: 1rem;
      padding: 1.25rem;
      background: white;
      border: 2px solid var(--gray-200);
      border-radius: var(--radius-lg);
      text-decoration: none;
      color: var(--gray-700);
      font-weight: 500;
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
    }

    .action-btn::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255,255,255,0.8), transparent);
      transition: left 0.6s;
    }

    .action-btn:hover::before {
      left: 100%;
    }

    .action-btn:hover {
      border-color: var(--primary-300);
      transform: translateY(-2px);
      box-shadow: var(--shadow-lg);
    }

    .action-btn.primary {
      background: linear-gradient(135deg, var(--primary-500), var(--primary-600));
      border-color: var(--primary-600);
      color: white;
    }

    .action-btn.success {
      background: linear-gradient(135deg, var(--success-500), var(--success-600));
      border-color: var(--success-600);
      color: white;
    }

    .action-btn.info {
      background: linear-gradient(135deg, var(--info-500), var(--info-600));
      border-color: var(--info-600);
      color: white;
    }

    .action-btn.danger {
      background: linear-gradient(135deg, var(--danger-500), var(--danger-600));
      border-color: var(--danger-600);
      color: white;
    }

    .action-icon {
      width: 48px;
      height: 48px;
      border-radius: var(--radius-md);
      background: rgba(255, 255, 255, 0.2);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.25rem;
      flex-shrink: 0;
    }

    .action-btn:not(.primary):not(.success):not(.info):not(.danger) .action-icon {
      background: var(--gray-100);
      color: var(--gray-600);
    }

    .action-content h3 {
      font-size: 1rem;
      font-weight: 600;
      margin-bottom: 0.25rem;
    }

    .action-content p {
      font-size: 0.875rem;
      opacity: 0.8;
    }

    /* Empty State */
    .empty-state {
      text-align: center;
      padding: 3rem 2rem;
      color: var(--gray-500);
    }

    .empty-state-icon {
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
      font-size: 1.125rem;
      font-weight: 600;
      color: var(--gray-700);
      margin-bottom: 0.5rem;
    }

    /* Success Message */
    .alert {
      background: var(--success-50);
      border: 1px solid var(--success-200);
      color: var(--success-800);
      padding: 1rem 1.5rem;
      border-radius: var(--radius-lg);
      margin-bottom: 2rem;
      display: flex;
      align-items: center;
      gap: 0.75rem;
    }

    /* Responsive Design */
    @media (max-width: 1024px) {
      .content-grid {
        grid-template-columns: 1fr;
      }
    }

    @media (max-width: 768px) {
      .header-container {
        flex-direction: column;
        text-align: center;
      }

      .user-info {
        text-align: center;
      }

      .main-container {
        padding: 1rem;
      }

      .stats-grid {
        grid-template-columns: 1fr;
      }

      .stat-card {
        padding: 1.5rem;
      }

      .card-body {
        padding: 1.5rem;
      }
    }

    @media (max-width: 480px) {
      .brand-text h1 {
        font-size: 1.5rem;
      }

      .stat-number {
        font-size: 1.875rem;
      }

      .prescription-item {
        padding: 1rem;
      }

      .action-btn {
        padding: 1rem;
      }

      .action-icon {
        width: 40px;
        height: 40px;
        font-size: 1rem;
      }
    }
  </style>
</head>

<body>
  <!-- Header -->
  <header class="header">
    <div class="header-container">
      <div class="brand">
        <div class="brand-icon">
          <i class="fas fa-pills"></i>
        </div>
        <div class="brand-text">
          <h1>PharmaCare</h1>
          <p>Pharmacist Dashboard</p>
        </div>
      </div>
      <div class="user-info">
        <div class="user-name">Welcome, Dr. Pharmacist</div>
        <div class="user-role">
          <i class="fas fa-user-md"></i>
          Licensed Pharmacist
        </div>
      </div>
    </div>
  </header>

  <!-- Main Content -->
  <main class="main-container">
    <!-- Success Message -->
    <c:if test="${not empty success}">
      <div class="alert">
        <i class="fas fa-check-circle"></i>
        <span>${success}</span>
      </div>
    </c:if>

    <!-- Stats Overview -->
    <div class="stats-grid">
      <div class="stat-card">
        <div class="stat-header">
          <div class="stat-icon pending">
            <i class="fas fa-clock"></i>
          </div>
        </div>
        <div class="stat-number">
          <c:choose>
            <c:when test="${not empty pending}">
              <c:set var="count" value="0" />
              <c:forEach items="${pending}" var="p">
                <c:set var="count" value="${count + 1}" />
              </c:forEach>
              ${count}
            </c:when>
            <c:otherwise>0</c:otherwise>
          </c:choose>
        </div>
        <div class="stat-label">Pending Prescriptions</div>
      </div>

      <div class="stat-card">
        <div class="stat-header">
          <div class="stat-icon completed">
            <i class="fas fa-check-circle"></i>
          </div>
        </div>
        <div class="stat-number">${completedToday != null ? completedToday : 0}</div>
        <div class="stat-label">Completed Today</div>
      </div>

      <div class="stat-card">
        <div class="stat-header">
          <div class="stat-icon inventory">
            <i class="fas fa-boxes"></i>
          </div>
        </div>
        <div class="stat-number">${lowStockCount != null ? lowStockCount : 0}</div>
        <div class="stat-label">Low Stock Items</div>
      </div>
    </div>

    <!-- Main Content Grid -->
    <div class="content-grid">
      <!-- Pending Prescriptions -->
      <div class="card">
        <div class="card-header">
          <h2 class="card-title">
            <i class="fas fa-prescription-bottle-alt"></i>
            Pending Prescriptions
          </h2>
        </div>
        <div class="card-body">
          <c:choose>
            <c:when test="${not empty pending}">
              <div class="prescription-list">
                <c:forEach items="${pending}" var="p">
                  <div class="prescription-item"
                       onclick="location.href='${pageContext.request.contextPath}/pharmacist/prescriptions/${p.patient.userId}'">
                    <div class="prescription-header">
                      <div class="patient-info">
                        <h4>${p.patient.name}</h4>
                        <div class="patient-meta">
                          <i class="fas fa-user"></i> Patient ID: ${p.patient.userId}
                          <span style="margin-left: 1rem;">
                            <i class="fas fa-calendar"></i> ${p.createdDate != null ? p.createdDate : 'Today'}
                          </span>
                        </div>
                      </div>
                      <span class="status-badge status-pending">${p.status}</span>
                    </div>
                    <div class="medicine-summary">
                      <i class="fas fa-pills"></i>
                      <span>${p.medicine.name} (Qty: ${p.qty})</span>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </c:when>
            <c:otherwise>
              <div class="empty-state">
                <div class="empty-state-icon">
                  <i class="fas fa-prescription-bottle-alt"></i>
                </div>
                <h3>No Pending Prescriptions</h3>
                <p>All prescriptions have been processed</p>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

      <!-- Quick Actions -->
      <div class="card">
        <div class="card-header">
          <h2 class="card-title">
            <i class="fas fa-bolt"></i>
            Quick Actions
          </h2>
        </div>
        <div class="card-body">
          <div class="actions-grid">
            <a href="${pageContext.request.contextPath}/pharmacist/new-prescription" class="action-btn primary">
              <div class="action-icon">
                <i class="fas fa-prescription-bottle-medical"></i>
              </div>
              <div class="action-content">
                <h3>New Prescription</h3>
                <p>Create prescription for patient</p>
              </div>
            </a>

            <a href="${pageContext.request.contextPath}/pharmacist/prescriptions" class="action-btn">
              <div class="action-icon">
                <i class="fas fa-list-alt"></i>
              </div>
              <div class="action-content">
                <h3>View Prescriptions</h3>
                <p>Browse all prescription records</p>
              </div>
            </a>

            <a href="${pageContext.request.contextPath}/pharmacist/medicine-inventory" class="action-btn info">
              <div class="action-icon">
                <i class="fas fa-warehouse"></i>
              </div>
              <div class="action-content">
                <h3>Medicine Inventory</h3>
                <p>Categorize & manage stock</p>
              </div>
            </a>

            <a href="${pageContext.request.contextPath}/pharmacist/reports" class="action-btn success">
              <div class="action-icon">
                <i class="fas fa-chart-line"></i>
              </div>
              <div class="action-content">
                <h3>Reports & Analytics</h3>
                <p>View performance metrics</p>
              </div>
            </a>

            <a href="${pageContext.request.contextPath}/logout" class="action-btn danger">
              <div class="action-icon">
                <i class="fas fa-sign-out-alt"></i>
              </div>
              <div class="action-content">
                <h3>Logout</h3>
                <p>Sign out of your session</p>
              </div>
            </a>
          </div>
        </div>
      </div>
    </div>
  </main>
</body>
</html>
