<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"            %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title>Cashier • Payments</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

  <style>
    /* base */
    *{box-sizing:border-box;margin:0;padding:0}
    body{font-family:'Segoe UI',Tahoma,sans-serif;background:#f4f7fa;color:#333;padding:30px 15px}

    /* nav */
    nav{background:#007bff;padding:12px 22px;border-radius:14px;
        box-shadow:0 6px 18px rgba(0,0,0,.15);text-align:center;margin-bottom:30px}
    nav a{color:#fff;font-weight:600;font-size:17px;margin:0 12px;text-decoration:none;transition:.3s}
    nav a:hover{color:#d2e3ff}

    /* card */
    .container{max-width:900px;margin:auto;background:#fff;padding:35px 45px;border-radius:18px;
               box-shadow:0 12px 32px rgba(0,0,0,.15)}
    h1{text-align:center;font-size:2rem;font-weight:800;margin-bottom:25px;color:#007bff}

    /* search bar */
    .search-form{display:flex;gap:12px;margin-bottom:30px}
    .search-form input{flex:1;padding:12px 18px;border-radius:30px;border:1px solid #ccc;font-size:15px}
    .search-form button{padding:0 25px;border:none;border-radius:30px;background:#1e90ff;
                        color:#fff;font-weight:700;cursor:pointer;transition:.3s}
    .search-form button:hover{background:#187bcd}

    /* table */
    table{width:100%;border-collapse:collapse;font-size:15px}
    thead{background:#1e90ff;color:#fff}
    th,td{padding:12px 15px;text-align:left;border-bottom:1px solid #eef}
    tbody tr:hover{background:#f0f7ff}
    .pay-btn{padding:6px 16px;border:none;border-radius:20px;background:#28a745;color:#fff;cursor:pointer}
    .pay-btn:hover{background:#218838}

    /* modal */
    .backdrop{position:fixed;inset:0;background:rgba(0,0,0,.55);display:none;
              align-items:center;justify-content:center;z-index:1000}
    .modal{background:#fff;border-radius:16px;padding:25px 30px;width:360px;
           box-shadow:0 8px 24px rgba(0,0,0,.25)}
    .modal h2{margin-bottom:20px;color:#007bff}
    select{width:100%;padding:10px 14px;font-size:15px;border:1px solid #ccc;border-radius:12px}
    .confirm{margin-top:25px;width:100%;padding:12px 0;border:none;border-radius:25px;
             background:#007bff;color:#fff;font-weight:700;cursor:pointer}
    .confirm:hover{background:#005ec4}
    .success{display:none;margin-top:20px;background:#d1e7dd;color:#146c43;
             padding:12px;font-weight:700;border-radius:12px;text-align:center}
  </style>
</head>
<body>

<nav>
  <a href="${pageContext.request.contextPath}/cashier/search"><i class="fas fa-cash-register"></i> Cashier Home</a>
  <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
</nav>

<div class="container">
  <h1>Search Payments</h1>

  <form class="search-form" action="${pageContext.request.contextPath}/cashier/search" method="get">
    <input type="text" name="userId" placeholder="Patient ID" value="${param.userId}">
    <input type="text" name="name"   placeholder="Patient Name" value="${param.name}">
    <button type="submit">Search</button>
  </form>

  <c:if test="${not empty payments}">
    <table>
      <thead>
        <tr><th>Patient</th><th>Medicine</th><th>Total</th><th>Status</th><th></th></tr>
      </thead>
      <tbody>
        <c:forEach var="p" items="${payments}">
          <tr>
            <td>${p.prescription.patient.name}</td>
            <td>${p.prescription.medicine.name}</td>
            <td>Rs.${p.total}</td>
            <td>${p.paymentStatus}</td>
            <td>
              <c:if test="${p.paymentStatus == 'PENDING'}">
                <button class="pay-btn" data-id="${p.paymentId}">Pay</button>
              </c:if>
              <c:if test="${p.paymentStatus == 'PAID'}">
                <span style="color:#28a745;font-weight:700">Paid</span>
              </c:if>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </c:if>
</div>

<!-- pop-up -->
<div class="backdrop" id="backdrop">
  <div class="modal">
    <h2>Select Payment Method</h2>
    <form id="payForm">
      <input type="hidden" name="paymentId" id="payId">
      <select name="paymentMethod" id="method">
        <option value="CASH">Cash</option>
        <option value="CARD">Card</option>
      </select>
      <button class="confirm" type="submit">Confirm</button>
      <div class="success" id="msg">Payment recorded successfully.</div>
    </form>
  </div>
</div>

<script>
  const backdrop  = document.getElementById('backdrop');
  const payForm   = document.getElementById('payForm');
  const payId     = document.getElementById('payId');
  const msg       = document.getElementById('msg');

  // open pop-up
  document.querySelectorAll('.pay-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      payId.value = btn.dataset.id;
      msg.style.display = 'none';
      backdrop.style.display = 'flex';
    });
  });

  // close when clicking outside modal
  backdrop.addEventListener('click', e => {
    if (e.target === backdrop) backdrop.style.display = 'none';
  });

  // AJAX submit
  payForm.addEventListener('submit', e => {
    e.preventDefault();
    fetch('${pageContext.request.contextPath}/cashier/pay', {
      method: 'POST',
      body: new FormData(payForm)
    })
    .then(r => {
      if (r.ok) {
        msg.style.display = 'block';
        setTimeout(() => window.location.reload(), 1500);
      } else { alert('Payment failed'); }
    })
    .catch(() => alert('Network error'));
  });
</script>
</body>
</html>
