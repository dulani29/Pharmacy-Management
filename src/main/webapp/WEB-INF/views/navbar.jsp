<nav class="navbar">
  <div class="nav-container">
    <a href="${pageContext.request.contextPath}/inventory/dashboard" class="nav-brand">
      <i class="fas fa-prescription-bottle-alt"></i> MediCare System
    </a>
    <ul class="nav-menu">
      <li><a href="${pageContext.request.contextPath}/inventory/dashboard" class="nav-item active">
        <i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
      <li><a href="${pageContext.request.contextPath}/inventory/add-stock" class="nav-item">
        <i class="fas fa-plus-circle"></i> Add Stock</a></li>
      <li><a href="${pageContext.request.contextPath}/inventory/reports" class="nav-item">
        <i class="fas fa-chart-bar"></i> Reports</a></li>
      <li><a href="${pageContext.request.contextPath}/inventory/categories" class="nav-item">
        <i class="fas fa-tags"></i> Categories</a></li>
      <li><a href="${pageContext.request.contextPath}/profile" class="nav-item">
        <i class="fas fa-user-circle"></i> Profile</a></li>
      <li>
        <form action="${pageContext.request.contextPath}/logout" method="GET" style="display:inline;">
          <button type="submit" class="nav-item logout-btn">
            <i class="fas fa-sign-out-alt"></i> Logout
          </button>
        </form>
      </li>
    </ul>
  </div>
</nav>

<style>
.navbar {
  background: linear-gradient(135deg, #ff6f00 0%, #ff8f00 100%);
  box-shadow: 0 4px 20px rgba(0,0,0,0.15);
  padding: 1rem 0;
  color: white;
  position: sticky;
  top: 0;
  z-index: 1000;
}

.nav-container {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 2rem;
}

.nav-brand {
  font-size: 1.8rem;
  font-weight: 700;
  color: white;
  text-decoration: none;
  display: flex;
  align-items: center;
  gap: 0.75rem;
  transition: opacity 0.3s ease;
}

.nav-brand:hover {
  opacity: 0.8;
  color: white;
}

.nav-menu {
  list-style: none;
  display: flex;
  gap: 0.5rem;
  align-items: center;
  margin: 0;
  padding: 0;
}

.nav-menu li {
  display: flex;
  align-items: center;
}

.nav-item {
  color: white;
  text-decoration: none;
  font-weight: 600;
  padding: 0.75rem 1rem;
  border-radius: 8px;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  transition: all 0.3s ease;
  border: none;
  background: none;
  font-size: 0.95rem;
  cursor: pointer;
}

.nav-item:hover,
.nav-item:focus,
.nav-item.active {
  background-color: rgba(255,255,255,0.2);
  transform: translateY(-2px);
  outline: none;
  color: white;
}

.nav-item .fas {
  font-size: 1rem;
}

.logout-btn {
  background-color: rgba(220, 53, 69, 0.2) !important;
  border: 1px solid rgba(220, 53, 69, 0.3);
}

.logout-btn:hover {
  background-color: rgba(220, 53, 69, 0.4) !important;
}

@media (max-width: 768px) {
  .nav-container {
    flex-direction: column;
    gap: 1rem;
    padding: 0 1rem;
  }

  .nav-menu {
    flex-wrap: wrap;
    justify-content: center;
    gap: 0.5rem;
  }

  .nav-item {
    padding: 0.5rem 0.75rem;
    font-size: 0.9rem;
  }

  .nav-brand {
    font-size: 1.5rem;
  }
}

@media (max-width: 480px) {
  .nav-menu {
    flex-direction: column;
    width: 100%;
    gap: 0.25rem;
  }

  .nav-item {
    justify-content: center;
    width: 100%;
  }
}
</style>
