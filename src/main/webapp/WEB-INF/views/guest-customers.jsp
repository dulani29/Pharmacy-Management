<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guest Customers – Admin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { font-family: Inter, system-ui, -apple-system, sans-serif; background: #f8fafc; color: #0f172a; }
        .dashboard { display:flex; min-height:100vh; }
        .sidebar { width: 280px; background: linear-gradient(180deg, #5b21b6 0%, #4c1d95 100%); color:#fff; position:fixed; height:100vh; left:0; top:0; box-shadow: 0 20px 25px -5px rgb(0 0 0 / .1); }
        .sidebar .brand { display:flex; align-items:center; gap:1rem; padding:1.5rem 2rem; border-bottom:1px solid rgba(255,255,255,.1); }
        .brand-icon { width:48px; height:48px; border-radius:12px; background: rgba(255,255,255,.2); display:flex; align-items:center; justify-content:center; font-size:1.25rem; }
        .nav-menu { padding: 1rem 0; }
        .nav-item { display:flex; align-items:center; gap:.75rem; color:#fff; text-decoration:none; padding:.85rem 2rem; border-radius:10px; margin:.25rem 1rem; }
        .nav-item i { width:20px; }
        .nav-item:hover, .nav-item.active { background: rgba(255,255,255,.15); }
        .main { flex:1; margin-left:280px; display:flex; flex-direction:column; min-height:100vh; }
        .header { background:#fff; border-bottom:1px solid #e2e8f0; padding:1.25rem 2rem; display:flex; align-items:center; justify-content:space-between; }
        .page-title { font-size:1.5rem; font-weight:800; }
        .content { padding:2rem; }
        .grid { display:grid; grid-template-columns: 380px 1fr; gap:1.5rem; }
        .card { background:#fff; border:1px solid #e2e8f0; border-radius:14px; box-shadow: 0 10px 20px -10px rgb(2 6 23 / .12); overflow:hidden; }
        .card-header { padding:.9rem 1.25rem; border-bottom:1px solid #e2e8f0; font-weight:700; background:#fafafa; }
        .card-body { padding:1rem 1.25rem; }
        .list-scroll { max-height:70vh; overflow:auto; }
        .item { padding:.8rem .9rem; border:1px solid #e5e7eb; border-radius:12px; margin-bottom:.75rem; cursor:pointer; display:flex; justify-content:space-between; align-items:center; background:#fff; transition:.2s; }
        .item:hover { background:#f8fafc; transform: translateY(-1px); box-shadow: 0 6px 10px -8px rgba(2,6,23,.2); }
        .muted { color:#64748b; font-size:.85rem; }
        .btn { display:inline-flex; align-items:center; gap:.5rem; padding:.6rem .9rem; border-radius:10px; border:1px solid #cbd5e1; background:#fff; cursor:pointer; transition:.2s; }
        .btn:hover { transform: translateY(-1px); box-shadow: 0 8px 16px -12px rgba(2,6,23,.3); }
        .btn.danger { background:#fef2f2; border-color:#fecaca; color:#dc2626; }
        .table-wrap { border:1px solid #e2e8f0; border-radius:12px; overflow:hidden; box-shadow: 0 8px 16px -12px rgba(2,6,23,.2); }
        .table-scroll { max-height:60vh; overflow:auto; }
        table { width:100%; border-collapse:separate; border-spacing:0; }
        thead th { position:sticky; top:0; background:#f1f5f9; z-index:1; }
        th, td { padding:.7rem .9rem; border-bottom:1px solid #e5e7eb; text-align:left; font-size:.925rem; }
        tbody tr:hover { background:#f8fafc; }
        tbody tr:nth-child(odd) { background:#fcfcfd; }
        @media (max-width: 992px){ .main{margin-left:0;} .sidebar{display:none;} .grid{grid-template-columns:1fr;} .list-scroll{max-height:none;} }
    </style>
    <script>
        function viewGuest(userId){ window.location.href = '<c:url value="/admin/guests"/>?userId=' + encodeURIComponent(userId); }
        function deleteGuest(userId, name){ if(!confirm('Delete guest '+name+' ('+userId+')?')) return; const f=document.getElementById('guestForm'); f.action = '<c:url value="/admin/guest/"/>' + encodeURIComponent(userId) + '/delete'; f.submit(); }
    </script>
    <form id="guestForm" method="post" style="display:none;"></form>
</head>
<body>
<div class="dashboard">
    <aside class="sidebar">
        <div class="brand">
            <div class="brand-icon"><i class="fas fa-shield-alt"></i></div>
            <div>
                <div style="font-weight:800;">PharmaCare</div>
                <div style="opacity:.85; font-size:.85rem;">Admin Panel</div>
            </div>
        </div>
        <nav class="nav-menu">
            <a href="<c:url value='/admin/dashboard'/>" class="nav-item"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
            <a href="<c:url value='/admin/loyalty-members'/>" class="nav-item"><i class="fas fa-crown"></i>Loyalty Members</a>
            <a href="<c:url value='/admin/guests'/>" class="nav-item active"><i class="fas fa-user"></i>Guest Customers</a>
        </nav>
    </aside>
    <main class="main">
        <header class="header">
            <div class="page-title"><i class="fas fa-user"></i> Guest Customers</div>
            <a class="btn" href="<c:url value='/admin/dashboard'/>"><i class="fas fa-arrow-left"></i> Back</a>
        </header>
        <div class="content">
            <c:if test="${not empty success}">
                <div style="background:#f0fdf4; border:1px solid #bbf7d0; color:#166534; padding:.8rem 1rem; border-radius:10px; margin-bottom:1rem;">
                    <i class="fas fa-check-circle"></i> ${success}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div style="background:#fef2f2; border:1px solid #fecaca; color:#991b1b; padding:.8rem 1rem; border-radius:10px; margin-bottom:1rem;">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>
            <div class="grid">
                <div class="card">
                    <div class="card-header">Guests</div>
                    <div class="card-body list-scroll">
                        <c:if test="${empty guests}"><div class="muted">No guests found.</div></c:if>
                        <c:forEach var="g" items="${guests}">
                            <div class="item" onclick="viewGuest('${g.userId}')">
                                <div>
                                    <div><strong>${g.name}</strong></div>
                                    <div class="muted">${g.userId} • ${g.phoneNumber}</div>
                                </div>
                                <button type="button" class="btn danger" onclick="event.stopPropagation(); deleteGuest('${g.userId}', '${g.name}')"><i class="fas fa-trash"></i> Delete</button>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header">Guest Details</div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty selectedGuest}">
                                <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:.75rem;">
                                    <div>
                                        <div><strong>${selectedGuest.name}</strong></div>
                                        <div class="muted">${selectedGuest.userId} • ${selectedGuest.phoneNumber}</div>
                                    </div>
                                    <button type="button" class="btn danger" onclick="deleteGuest('${selectedGuest.userId}', '${selectedGuest.name}')"><i class="fas fa-user-times"></i> Delete Guest</button>
                                </div>
                                <h4 style="margin:1rem 0 .5rem 0; font-size:1.05rem; font-weight:800;">Payment History</h4>
                                <c:if test="${empty payments}"><div class="muted">No payments found.</div></c:if>
                                <c:if test="${not empty payments}">
                                    <div class="table-wrap"><div class="table-scroll">
                                        <table>
                                            <thead>
                                            <tr>
                                                <th>Date</th>
                                                <th>Method</th>
                                                <th>Total</th>
                                                <th>Points Used</th>
                                                <th>Points Earned</th>
                                                <th>Status</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="p" items="${payments}">
                                                <tr>
                                                    <td><c:out value="${p.paymentDate}"/></td>
                                                    <td>${p.paymentMethod}</td>
                                                    <td>Rs. <c:out value="${p.total}"/></td>
                                                    <td><c:out value="${p.pointsUsed}"/></td>
                                                    <td><c:out value="${p.pointsEarned}"/></td>
                                                    <td>${p.paymentStatus}</td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div></div>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <div class="muted">Select a guest to view details and payment history.</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>


