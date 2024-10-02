<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String tokenExpired = (String) request.getAttribute("tokenExpired");
    System.out.println("TokenExpiredInIndexPageStatus: " + tokenExpired);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <script>
        //handle token expiry redirect
        var tokenExpired = "<%= tokenExpired %>";
        // console.log("TokenExpired: " + tokenExpired)
        // console.log("TokenExpired: " + typeof tokenExpired)
        if (tokenExpired === "true") {
            window.top.location.href = "/"
        }
    </script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.png" type="image/x-icon">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globalAlert.css">

    <title>Election Commission Of India</title>

</head>
<body>


<%
    String errorMessage = (String) request.getAttribute("error");
    String successMessage = (String) request.getAttribute("success");
    System.out.println("error Msg: " + errorMessage);
%>

<div id="alert"></div>
<%
    if (errorMessage != null) {
%>
<script type="module">
    // show db alerts
    import { showAlert } from '${pageContext.request.contextPath}/js/globalAlert.js';
    console.log("Loaded")
    showAlert('failed', '<%= errorMessage%>')

</script>

<%
    }
%>

<%
    if (successMessage != null) {
%>
<script type="module">
    // show db alerts
    import { showAlert } from '${pageContext.request.contextPath}/js/globalAlert.js';
    showAlert('success', '<%= successMessage%>')

</script>

<%
    }
%>


<!-- Include header here -->
<header>
    <a href="/">
        <img src="${pageContext.request.contextPath}/images/National_Emblem.png" alt="National Emblem" class="logo">
    </a>

    <p class="header-text"><img src="${pageContext.request.contextPath}/images/eci-logo.svg" alt="Election Commission of India"></p>
</header>


<!-- Full-Screen Splash -->
<div id="splash">
    <!-- Add GIF here -->
    <img src="${pageContext.request.contextPath}/images/namaste.gif" alt="Namaskaram GIF">
    <h1>नमस्कारम्</h1>
</div>

<!-- Main Content -->
<div class="content">
    <div class="left-section">
        <div class="carousel">
            <!-- Carousel Images -->
            <img width="2544" height="1272" id="carousel-image-1" src="${pageContext.request.contextPath}/images/c1tr.jpg" alt="Indian Culture 1"
                 class="show">
            <img width="2544" height="1272" id="carousel-image-2" src="${pageContext.request.contextPath}/images/c2-transformed.jpeg"
                 alt="Indian Culture 2">
            <img width="2544" height="1272" id="carousel-image-3" src="${pageContext.request.contextPath}/images/c3tr.jpg" alt="Indian Culture 3">
            <img width="2544" height="1272" id="carousel-image-4" src="${pageContext.request.contextPath}/images/c4tr.jpg" alt="Indian Culture 3">
            <img width="2544" height="1272" id="carousel-image-5" src="${pageContext.request.contextPath}/images/c5tr.jpg" alt="Indian Culture 3">
            <img width="2544" height="1272" id="carousel-image-6" src="${pageContext.request.contextPath}/images/c6tr.jpg" alt="Indian Culture 3">
            <div class="carousel-text"></div>
        </div>
    </div>

    <div class="right-section">
        <h2>Login</h2>
        <form class="login-form" action="/user/login" method="post">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="Enter your email" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>

            <button type="submit">Login</button>

            <p class="voter-register-link"><a href="/user/registration-form" style="text-decoration: none;"><strong
                    style="color: red">New Voter Registration?</strong></a></p>

        </form>
    </div>
</div>

<script>

    const splash = document.getElementById('splash');
    const content = document.querySelector('.content');
    if (!localStorage.getItem('splashLoaded')) {
        // Splash fade-out effect
        document.addEventListener('DOMContentLoaded', function () {

            setTimeout(() => {
                splash.classList.add('fade-out'); // Fade out the splash
                content.classList.add('show');    // Show the main content after splash fades out
            }, 3000);  // Splash visible for 3 seconds
        });
        localStorage.setItem('splashLoaded', true)
    } else {
        // Directly show main content if splash was shown before
        content.classList.add('show')
        splash.style.display = 'none'
    }


    // Carousel functionality
    const images = [
        document.getElementById('carousel-image-1'),
        document.getElementById('carousel-image-2'),
        document.getElementById('carousel-image-3'),
        document.getElementById('carousel-image-4'),
        document.getElementById('carousel-image-5'),
        document.getElementById('carousel-image-6'),
    ];

    let currentIndex = 0;

    // Function to cycle through carousel images
    function showNextImage() {
        images[currentIndex].classList.remove('show');
        currentIndex = (currentIndex + 1) % images.length;
        images[currentIndex].classList.add('show');
    }

    // Start the carousel after splash has faded out
    setTimeout(() => {
        setInterval(showNextImage, 3000);  // Switch image every 3 seconds
    }, 3000);  // Start after 3 seconds (when splash fades out)
</script>

<script type="module">
    import { showAlert } from '${pageContext.request.contextPath}/js/globalAlert.js';
    window.onload = ()=>{
        // Check if there's a logout message in session storage
        const message = sessionStorage.getItem('logoutMessage');

        if(message){
            showAlert('success', message)

            // Remove the message from session storage after displaying it
            sessionStorage.removeItem('logoutMessage');
        }
    }
</script>


</body>
</html>