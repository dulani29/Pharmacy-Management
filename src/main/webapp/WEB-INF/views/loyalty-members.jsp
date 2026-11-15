<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loyalty Members – Admin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-500: #6366f1; --primary-600: #5b21b6; --primary-700: #4c1d95;
            --secondary-500: #10b981; --secondary-600: #059669; --secondary-700: #047857;
            --gray-50:#f9fafb; --gray-100:#f3f4f6; --gray-200:#e5e7eb; --gray-300:#d1d5db; --gray-600:#4b5563; --gray-900:#111827;
        }
        body { font-family: Inter, system-ui, -apple-system, sans-serif; background: var(--gray-50); color: var(--gray-900); }
        .dashboard { display:flex; min-height:100vh; }
        /* Sidebar (matched with admin-dashboard) */
        .sidebar { width: 280px; background: linear-gradient(180deg, var(--primary-600) 0%, var(--primary-700) 100%); color:#fff; position:fixed; height:100vh; left:0; top:0; box-shadow: 0 20px 25px -5px rgb(0 0 0 / .1); }
        .sidebar .brand { display:flex; align-items:center; gap:1rem; padding:1.5rem 2rem; border-bottom:1px solid rgba(255,255,255,.1); }
        .brand-icon { width:48px; height:48px; border-radius:12px; background: rgba(255,255,255,.2); display:flex; align-items:center; justify-content:center; font-size:1.25rem; }
        .nav-menu { padding: 1rem 0; }
        .nav-item { display:flex; align-items:center; gap:.75rem; color:#fff; text-decoration:none; padding:.85rem 2rem; border-radius:10px; margin:.25rem 1rem; }
        .nav-item i { width:20px; }
        .nav-item:hover, .nav-item.active { background: rgba(255,255,255,.15); }
        /* Main */
        .main { flex:1; margin-left:280px; display:flex; flex-direction:column; min-height:100vh; }
        .header { background:#fff; border-bottom:1px solid var(--gray-200); padding:1.25rem 2rem; display:flex; align-items:center; justify-content:space-between; }
        .page-title { font-size:1.5rem; font-weight:800; }
        .content { padding: 2rem; }
        /* Cards and content (from previous basic styling) */
        .grid { display:grid; grid-template-columns: 380px 1fr; gap:1.5rem; }
        .card { background: #fff; border: 1px solid #e2e8f0; border-radius: 14px; box-shadow: 0 10px 20px -10px rgb(2 6 23 / 0.12); overflow:hidden; }
        .card-header { padding: 0.9rem 1.25rem; border-bottom: 1px solid #e2e8f0; font-weight: 700; background:#fafafa; }
        .card-body { padding: 1rem 1.25rem; }
        .members-scroll { max-height: 70vh; overflow:auto; padding-right:.25rem; }
        .member { padding:.8rem .9rem; border:1px solid #e5e7eb; border-radius:12px; margin-bottom:.75rem; cursor:pointer; display:flex; justify-content:space-between; align-items:center; transition:.2s; background:#fff; }
        .member:hover { background:#f8fafc; transform: translateY(-1px); box-shadow: 0 6px 10px -8px rgba(2,6,23,.2); }
        .badge { padding:.25rem .5rem; border-radius:9999px; background:#ecfeff; color:#0369a1; font-size:.75rem; border:1px solid #bae6fd; }
        .btn { display:inline-flex; align-items:center; gap:.5rem; padding:.6rem .9rem; border-radius:10px; border:1px solid #cbd5e1; background:#fff; cursor:pointer; transition:.2s; }
        .btn:hover { transform: translateY(-1px); box-shadow: 0 8px 16px -12px rgba(2,6,23,.3); }
        .btn.danger { background:#fef2f2; border-color:#fecaca; color:#dc2626; }
        .btn.primary { background:#eef2ff; border-color:#c7d2fe; color:#4f46e5; }
        .table-wrap { border:1px solid #e2e8f0; border-radius: 12px; overflow:hidden; box-shadow: 0 8px 16px -12px rgba(2,6,23,.2); }
        .table-scroll { max-height:60vh; overflow:auto; }
        table { width:100%; border-collapse: separate; border-spacing:0; }
        thead th { position: sticky; top: 0; background:#f1f5f9; z-index: 1; }
        th, td { padding:.7rem .9rem; border-bottom:1px solid #e5e7eb; text-align:left; font-size:.925rem; }
        tbody tr:hover { background:#f8fafc; }
        tbody tr:nth-child(odd) { background:#fcfcfd; }
        .muted { color:#64748b; font-size:.85rem; }
        .tag { display:inline-flex; align-items:center; gap:.4rem; padding:.25rem .55rem; border-radius:9999px; font-size:.75rem; font-weight:600; border:1px solid; }
        .tag.earned { background:#f0fdf4; color:#166534; border-color:#bbf7d0; }
        .tag.redeemed { background:#fef2f2; color:#991b1b; border-color:#fecaca; }
        .points-positive { color:#166534; font-weight:700; }
        .points-negative { color:#991b1b; font-weight:700; }
        @media (max-width: 992px) { .main{margin-left:0;} .sidebar{display:none;} .grid{ grid-template-columns:1fr;} .members-scroll{max-height:none;} }
    </style>
    <script>
        function viewMember(userId) {
            const url = '${pageContext.request.contextPath}/admin/loyalty-members?userId=' + encodeURIComponent(userId);
            window.location.href = url;
        }
        function removeMember(userId, name) {
            if (!confirm('Remove loyalty membership for ' + name + '? This will reset points to 0.')) return;
            const form = document.getElementById('removeForm');
            form.action = '${pageContext.request.contextPath}/admin/loyalty-member/' + encodeURIComponent(userId) + '/remove';
            form.submit();
        }
        function deleteMember(userId, name) {
            if (!confirm('Delete member ' + name + ' (' + userId + ')? This cannot be undone.')) return;
            const form = document.getElementById('removeForm');
            form.action = '${pageContext.request.contextPath}/admin/loyalty-member/' + encodeURIComponent(userId) + '/delete';
            form.submit();
        }
    </script>
    <form id="removeForm" method="post" style="display:none;"></form>
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
            <a href="<c:url value='/admin/users'/>" class="nav-item"><i class="fas fa-users"></i>User Management</a>
            <a href="<c:url value='/admin/loyalty-members'/>" class="nav-item active"><i class="fas fa-crown"></i>Loyalty Members</a>
            <a href="<c:url value='/admin/offers'/>" class="nav-item"><i class="fas fa-tags"></i>Offers</a>
            <a href="<c:url value='/inventory/dashboard'/>" class="nav-item"><i class="fas fa-boxes"></i>Inventory</a>
        </nav>
    </aside>
    <main class="main">
        <header class="header">
            <div class="page-title"><i class="fas fa-crown"></i> Loyalty Members</div>
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
            <div class="card-header">Members</div>
                    <div class="card-body members-scroll">
                <c:if test="${empty members}">
                    <div class="muted">No loyalty members found.</div>
                </c:if>
                <c:forEach var="m" items="${members}">
                    <div class="member" onclick="viewMember('${m.userId}')">
                        <div>
                            <div><strong>${m.name}</strong></div>
                            <div class="muted">${m.userId} • ${m.phoneNumber}</div>
                        </div>
                        <div>
                            <span class="badge">Points: ${m.totalPoints}</span>
                        </div>
                    </div>
                </c:forEach>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">Member Details</div>
                    <div class="card-body">
                <c:choose>
                    <c:when test="${not empty selectedMember}">
                        <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:0.75rem;">
                                    <div>
                                        <div><strong>${selectedMember.name}</strong></div>
                                        <div class="muted">${selectedMember.userId} • ${selectedMember.phoneNumber}</div>
                                        <div class="muted">Points: ${selectedMember.totalPoints}</div>
                                    </div>
                                    <div style="display:flex; gap:.5rem;">
                                        <button type="button" class="btn danger" onclick="removeMember('${selectedMember.userId}', '${selectedMember.name}')">
                                            <i class="fas fa-user-slash"></i> Remove Membership
                                        </button>
                                        <button type="button" class="btn" onclick="deleteMember('${selectedMember.userId}', '${selectedMember.name}')">
                                            <i class="fas fa-user-times"></i> Delete Member
                                        </button>
                                    </div>
                        </div>

                        <h4 style="margin:1rem 0 0.5rem 0; font-size:1.05rem; font-weight:800;">Transactions</h4>
                        <c:if test="${empty transactions}">
                            <div class="muted">No transactions found.</div>
                        </c:if>
                        <c:if test="${not empty transactions}">
                            <div class="table-wrap">
                                <div class="table-scroll">
                                    <table>
                                        <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Type</th>
                                            <th>Points</th>
                                            <th>Payment Ref</th>
                                            <th>Description</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="t" items="${transactions}">
                                            <tr>
                                                <td>${t.transactionDate}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${t.transactionType == 'EARNED'}">
                                                            <span class="tag earned"><i class="fas fa-arrow-trend-up"></i>EARNED</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="tag redeemed"><i class="fas fa-arrow-trend-down"></i>REDEEMED</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${t.transactionType == 'EARNED'}">
                                                            <span class="points-positive">+${t.points}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="points-negative">-${t.points}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td><c:out value="${t.referencePaymentId}"/></td>
                                                <td><c:out value="${t.description}"/></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="muted">Select a member to view details and history.</div>
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


