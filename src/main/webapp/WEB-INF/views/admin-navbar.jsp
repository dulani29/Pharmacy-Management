<nav class="admin-navbar" style="background: linear-gradient(90deg, #28a745 0%, #20c997 100%); color: white; box-shadow: 0 3px 12px rgba(40,167,69,0.08); padding: 0.75rem 0;">
  <div style="max-width: 1200px; margin: 0 auto; display: flex; align-items: center; justify-content: space-between; padding: 0 2rem;">
    <div style="font-weight: 700; font-size: 1.5rem;">
      <i class="fas fa-shield-alt"></i> Admin Panel
    </div>
    <ul style="list-style: none; display: flex; gap: 1.25rem; align-items: center; margin: 0; padding: 0;">
      <li><a href="${pageContext.request.contextPath}/admin/dashboard" style="color: white; font-weight: 600; text-decoration: none;"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
      <li><a href="${pageContext.request.contextPath}/admin/users" style="color: white; font-weight: 600; text-decoration: none;"><i class="fas fa-users"></i> User Management</a></li>
      <li><a href="${pageContext.request.contextPath}/admin/reports" style="color: white; font-weight: 600; text-decoration: none;"><i class="fas fa-chart-bar"></i> Reports</a></li>
      <li><a href="${pageContext.request.contextPath}/admin/settings" style="color: white; font-weight: 600; text-decoration: none;"><i class="fas fa-cogs"></i> Settings</a></li>
      <li><a href="${pageContext.request.contextPath}/logout" style="color: #ffc107; font-weight: 600; text-decoration: none;"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
    </ul>
  </div>
</nav>
