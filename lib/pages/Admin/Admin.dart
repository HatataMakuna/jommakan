
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  

    <link rel="apple-touch-icon" type="image/png" href="https://cpwebassets.codepen.io/assets/favicon/apple-touch-icon-5ae1a0698dcc2402e9712f7d01ed509a57814f994c660df9f7a952f3060705ee.png" />

    <meta name="apple-mobile-web-app-title" content="CodePen">

    <link rel="shortcut icon" type="image/x-icon" href="https://cpwebassets.codepen.io/assets/favicon/favicon-aec34940fbc1a6e787974dcd360f2c6b63348d4b1f4e06c77743096d55480f33.ico" />

    <link rel="mask-icon" type="image/x-icon" href="https://cpwebassets.codepen.io/assets/favicon/logo-pin-b4b4269c16397ad2f0f7a01bcdf513a1994f4c94b8af2f191c09eb0d601762b1.svg" color="#111" />



  <meta charset="utf-8">
  <meta name='viewport' content='width=device-width, initial-scale=1'>

  <title>CodePen - Dashboard</title>

  <link rel="stylesheet" media="screen" href="https://cpwebassets.codepen.io/assets/fullpage/fullpage-7d0085e88e3f06095d712efc55f79fc6aedaeed08967649de30e3ea674797898.css" />
  

    <link rel="apple-touch-icon" type="image/png" href="https://cpwebassets.codepen.io/assets/favicon/apple-touch-icon-5ae1a0698dcc2402e9712f7d01ed509a57814f994c660df9f7a952f3060705ee.png" />

    <meta name="apple-mobile-web-app-title" content="CodePen">

    <link rel="shortcut icon" type="image/x-icon" href="https://cpwebassets.codepen.io/assets/favicon/favicon-aec34940fbc1a6e787974dcd360f2c6b63348d4b1f4e06c77743096d55480f33.ico" />

    <link rel="mask-icon" type="image/x-icon" href="https://cpwebassets.codepen.io/assets/favicon/logo-pin-b4b4269c16397ad2f0f7a01bcdf513a1994f4c94b8af2f191c09eb0d601762b1.svg" color="#111" />





  <title>CodePen - Dashboard</title>

  <style>
    html { font-size: 15px; }
    html, body { margin: 0; padding: 0; min-height: 100%; }
    body { height:100%; display: flex; flex-direction: column; }
    .referer-warning {
      background: black;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.5);
      padding: 0.75em;
      color: white;
      text-align: center;
      font-family: 'Lato', 'Lucida Grande', 'Lucida Sans Unicode', Tahoma, system-ui, Sans-Serif;
      line-height: 1.2;
      font-size: 1rem;
      position: relative;
      z-index: 2;
    }
    .referer-warning span { font-family: initial; }
    .referer-warning h1 { font-size: 1.2rem; margin: 0; }
    .referer-warning a { color: #56bcf9; }
  </style>
</head>

<body class="">
  <div class="referer-warning">
    <h1><span>⚠️</span> Do not enter passwords or personal information on this page. <span>⚠️</span></h1>
      This is a code demo posted by a web developer on <a href="https://codepen.io">CodePen</a>.
    <br />
    A referer from CodePen is required to render this page view, and your browser is not sending one (<a href="https://blog.codepen.io/2017/10/05/regarding-referer-headers/" target="_blank" rel="noreferrer noopener">more details</a>).</h1>
  </div>

  <div id="result-iframe-wrap" role="main">
    <iframe
      id="result"
      srcdoc="<!DOCTYPE html>
<html lang=&quot;en&quot; >

<head>
  <meta charset=&quot;UTF-8&quot;>
  

    <link rel=&quot;apple-touch-icon&quot; type=&quot;image/png&quot; href=&quot;https://cpwebassets.codepen.io/assets/favicon/apple-touch-icon-5ae1a0698dcc2402e9712f7d01ed509a57814f994c660df9f7a952f3060705ee.png&quot; />

    <meta name=&quot;apple-mobile-web-app-title&quot; content=&quot;CodePen&quot;>

    <link rel=&quot;shortcut icon&quot; type=&quot;image/x-icon&quot; href=&quot;https://cpwebassets.codepen.io/assets/favicon/favicon-aec34940fbc1a6e787974dcd360f2c6b63348d4b1f4e06c77743096d55480f33.ico&quot; />

    <link rel=&quot;mask-icon&quot; type=&quot;image/x-icon&quot; href=&quot;https://cpwebassets.codepen.io/assets/favicon/logo-pin-b4b4269c16397ad2f0f7a01bcdf513a1994f4c94b8af2f191c09eb0d601762b1.svg&quot; color=&quot;#111&quot; />



  
    <script src=&quot;https://cpwebassets.codepen.io/assets/common/stopExecutionOnTimeout-2c7831bb44f98c1391d6a4ffda0e1fd302503391ca806e7fcc7b9b87197aec26.js&quot;></script>


  <title>CodePen - Dashboard</title>

    <link rel=&quot;canonical&quot; href=&quot;https://codepen.io/themustafaomar/pen/jLMPKm&quot;>
  
  
  <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css'>
<link rel='stylesheet' href='https://unicons.iconscout.com/release/v3.0.6/css/line.css'>
  
<style>
@import 'https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&amp;display=swap&quot; rel=&quot;stylesheet';

:root {
	--dk-gray-100: #F3F4F6;
	--dk-gray-200: #E5E7EB;
	--dk-gray-300: #D1D5DB;
	--dk-gray-400: #9CA3AF;
	--dk-gray-500: #6B7280;
	--dk-gray-600: #4B5563;
	--dk-gray-700: #374151;
	--dk-gray-800: #1F2937;
	--dk-gray-900: #111827;
	--dk-dark-bg: #313348;
	--dk-darker-bg: #2a2b3d;
	--navbar-bg-color: #6f6486;
	--sidebar-bg-color: #252636;
	--sidebar-width: 250px;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Inter', sans-serif;
	background-color: var(--dk-darker-bg);
	font-size: .925rem;
}

#wrapper {
	margin-left: var(--sidebar-width);
	transition: all .3s ease-in-out;
}

#wrapper.fullwidth {
	margin-left: 0;
}



/** --------------------------------
 -- Sidebar
-------------------------------- */
.sidebar {
	background-color: var(--sidebar-bg-color);
	width: var(--sidebar-width);
	transition: all .3s ease-in-out;
	transform: translateX(0);
	z-index: 9999999
}

.sidebar .close-aside {
	position: absolute;
	top: 7px;
	right: 7px;
	cursor: pointer;
	color: #EEE;
}

.sidebar .sidebar-header {
	border-bottom: 1px solid #2a2b3c
}

.sidebar .sidebar-header h5 a {
	color: var(--dk-gray-300)
}

.sidebar .sidebar-header p {
	color: var(--dk-gray-400);
	font-size: .825rem;
}

.sidebar .search .form-control ~ i {
	color: #2b2f3a;
	right: 40px;
	top: 22px;
}

.sidebar > ul > li {
	padding: .7rem 1.75rem;
}

.sidebar ul > li > a {
	color: var(--dk-gray-400);
	text-decoration: none;
}

/* Start numbers */
.sidebar ul > li > a > .num {
	line-height: 0;
	border-radius: 3px;
	font-size: 14px;
	padding: 0px 5px
}

.sidebar ul > li > i {
	font-size: 18px;
	margin-right: .7rem;
	color: var(--dk-gray-500);
}

.sidebar ul > li.has-dropdown > a:after {
	content: '\eb3a';
	font-family: unicons-line;
	font-size: 1rem;
	line-height: 1.8;
	float: right;
	color: var(--dk-gray-500);
	transition: all .3s ease-in-out;
}

.sidebar ul .opened > a:after {
	transform: rotate(-90deg);
}

/* Start dropdown menu */
.sidebar ul .sidebar-dropdown {
	padding-top: 10px;
	padding-left: 30px;
	display: none;
}
.sidebar ul .sidebar-dropdown.active {
	display: block;
}

.sidebar ul .sidebar-dropdown > li > a {
  font-size: .85rem;
	padding: .5rem 0;
	display: block;
}
/* End dropdown menu */

.show-sidebar {
	transform: translateX(-270px);
}

@media (max-width: 767px) {
	.sidebar ul > li {
		padding-top: 12px;
		padding-bottom: 12px;
	}

	.sidebar .search {
		padding: 10px 0 10px 30px
	}
}




/** --------------------------------
 -- welcome
-------------------------------- */
.welcome {
	color: var(--dk-gray-300);
}

.welcome .content {
	background-color: var(--dk-dark-bg);
}

.welcome p {
	color: var(--dk-gray-400);
}




/** --------------------------------
 -- Statistics
-------------------------------- */
.statistics {
	color: var(--dk-gray-200);
}

.statistics .box {
	background-color: var(--dk-dark-bg);
}

.statistics .box i {
	width: 60px;
	height: 60px;
	line-height: 60px;
}

.statistics .box p {
	color: var(--dk-gray-400);
}




/** --------------------------------
 -- Charts
-------------------------------- */
.charts .chart-container {
	background-color: var(--dk-dark-bg);
}

.charts .chart-container h3 {
	color: var(--dk-gray-400)
}




/** --------------------------------
 -- users
-------------------------------- */
.admins .box .admin {
	background-color: var(--dk-dark-bg);
}

.admins .box h3 {
	color: var(--dk-gray-300);
}

.admins .box p {
	color: var(--dk-gray-400)
}




/** --------------------------------
 -- statis
-------------------------------- */
.statis {
	color: var(--dk-gray-100);
}

.statis .box {
	position: relative;
	overflow: hidden;
	border-radius: 3px;
}

.statis .box h3:after {
	content: &quot;&quot;;
	height: 2px;
	width: 70%;
	margin: auto;
	background-color: rgba(255, 255, 255, 0.12);
	display: block;
	margin-top: 10px;
}

.statis .box i {
	position: absolute;
	height: 70px;
	width: 70px;
	font-size: 22px;
	padding: 15px;
	top: -25px;
	left: -25px;
	background-color: rgba(255, 255, 255, 0.15);
	line-height: 60px;
	text-align: right;
	border-radius: 50%;
}





.main-color {
	color: #ffc107
}

/** --------------------------------
 -- Please don't do that in real-world projects!
 -- overwrite Bootstrap variables instead.
-------------------------------- */

.navbar {
	background-color: var(--navbar-bg-color) !important;
	border: none !important;
}
.navbar .dropdown-menu {
	right: auto !important;
	left: 0 !important;
}
.navbar .navbar-nav>li>a {
	color: #EEE !important;
	line-height: 55px !important;
	padding: 0 10px !important;
}
.navbar .navbar-brand {color:#FFF !important}
.navbar .navbar-nav>li>a:focus,
.navbar .navbar-nav>li>a:hover {color: #EEE !important}

.navbar .navbar-nav>.open>a,
.navbar .navbar-nav>.open>a:focus,
.navbar .navbar-nav>.open>a:hover {background-color: transparent !important; color: #FFF !important}

.navbar .navbar-brand {line-height: 55px !important; padding: 0 !important}
.navbar .navbar-brand:focus,
.navbar .navbar-brand:hover {color: #FFF !important}
.navbar>.container .navbar-brand, .navbar>.container-fluid .navbar-brand {margin: 0 !important}
@media (max-width: 767px) {
	.navbar>.container-fluid .navbar-brand {
		margin-left: 15px !important;
	}
	.navbar .navbar-nav>li>a {
		padding-left: 0 !important;
	}
	.navbar-nav {
		margin: 0 !important;
	}
	.navbar .navbar-collapse,
	.navbar .navbar-form {
		border: none !important;
	}
}

.navbar .navbar-nav>li>a {
	float: left !important;
}
.navbar .navbar-nav>li>a>span:not(.caret) {
	background-color: #e74c3c !important;
	border-radius: 50% !important;
	height: 25px !important;
	width: 25px !important;
	padding: 2px !important;
	font-size: 11px !important;
	position: relative !important;
	top: -10px !important;
	right: 5px !important
}
.dropdown-menu>li>a {
	padding-top: 5px !important;
	padding-right: 5px !important;
}
.navbar .navbar-nav>li>a>i {
	font-size: 18px !important;
}




/* Start media query */

@media (max-width: 767px) {
	#wrapper {
		margin: 0 !important
	}
	.statistics .box {
		margin-bottom: 25px !important;
	}
	.navbar .navbar-nav .open .dropdown-menu>li>a {
		color: #CCC !important
	}
	.navbar .navbar-nav .open .dropdown-menu>li>a:hover {
		color: #FFF !important
	}
	.navbar .navbar-toggle{
		border:none !important;
		color: #EEE !important;
		font-size: 18px !important;
	}
	.navbar .navbar-toggle:focus, .navbar .navbar-toggle:hover {background-color: transparent !important}
}


::-webkit-scrollbar {
	background: transparent;
	width: 5px;
	height: 5px;
}

::-webkit-scrollbar-thumb {
	background-color: #3c3f58;
}

::-webkit-scrollbar-thumb:hover {
	background-color: rgba(0, 0, 0, 0.3);
}
</style>

  <script>
  window.console = window.console || function(t) {};
</script>

  
  
</head>

<body translate=&quot;no&quot;>
  <aside class=&quot;sidebar position-fixed top-0 left-0 overflow-auto h-100 float-left&quot; id=&quot;show-side-navigation1&quot;>
  <i class=&quot;uil-bars close-aside d-md-none d-lg-none&quot; data-close=&quot;show-side-navigation1&quot;></i>
  <div class=&quot;sidebar-header d-flex justify-content-center align-items-center px-3 py-4&quot;>
    <img
         class=&quot;rounded-pill img-fluid&quot;
         width=&quot;65&quot;
         src=&quot;https://uniim1.shutterfly.com/ng/services/mediarender/THISLIFE/021036514417/media/23148907008/medium/1501685726/enhance&quot;
         alt=&quot;&quot;>
    <div class=&quot;ms-2&quot;>
      <h5 class=&quot;fs-6 mb-0&quot;>
        <a class=&quot;text-decoration-none&quot; href=&quot;#&quot;>Jone Doe</a>
      </h5>
      <p class=&quot;mt-1 mb-0&quot;>Lorem ipsum dolor sit amet consectetur.</p>
    </div>
  </div>

  <div class=&quot;search position-relative text-center px-4 py-3 mt-2&quot;>
    <input type=&quot;text&quot; class=&quot;form-control w-100 border-0 bg-transparent&quot; placeholder=&quot;Search here&quot;>
    <i class=&quot;fa fa-search position-absolute d-block fs-6&quot;></i>
  </div>

  <ul class=&quot;categories list-unstyled&quot;>
    <li class=&quot;has-dropdown&quot;>
      <i class=&quot;uil-estate fa-fw&quot;></i><a href=&quot;#&quot;> Dashboard</a>
      <ul class=&quot;sidebar-dropdown list-unstyled&quot;>
        <li><a href=&quot;#&quot;>Lorem ipsum</a></li>
        <li><a href=&quot;#&quot;>ipsum dolor</a></li>
        <li><a href=&quot;#&quot;>dolor ipsum</a></li>
        <li><a href=&quot;#&quot;>amet consectetur</a></li>
        <li><a href=&quot;#&quot;>ipsum dolor sit</a></li>
      </ul>
    </li>
    <li class=&quot;&quot;>
      <i class=&quot;uil-folder&quot;></i><a href=&quot;#&quot;> File manager</a>
    </li>
    <li class=&quot;has-dropdown&quot;>
      <i class=&quot;uil-calendar-alt&quot;></i><a href=&quot;#&quot;> Calender</a>
      <ul class=&quot;sidebar-dropdown list-unstyled&quot;>
        <li><a href=&quot;#&quot;>Lorem ipsum</a></li>
        <li><a href=&quot;#&quot;>ipsum dolor</a></li>
        <li><a href=&quot;#&quot;>dolor ipsum</a></li>
        <li><a href=&quot;#&quot;>amet consectetur</a></li>
        <li><a href=&quot;#&quot;>ipsum dolor sit</a></li>
      </ul>
    </li>
    <li class=&quot;has-dropdown&quot;>
      <i class=&quot;uil-envelope-download fa-fw&quot;></i><a href=&quot;#&quot;> Mailbox</a>
      <ul class=&quot;sidebar-dropdown list-unstyled&quot;>
        <li><a href=&quot;#&quot;>Lorem ipsum</a></li>
        <li><a href=&quot;#&quot;>ipsum dolor</a></li>
        <li><a href=&quot;#&quot;>dolor ipsum</a></li>
        <li><a href=&quot;#&quot;>amet consectetur</a></li>
        <li><a href=&quot;#&quot;>ipsum dolor sit</a></li>
      </ul>
    </li>
    <li class=&quot;has-dropdown&quot;>
      <i class=&quot;uil-shopping-cart-alt&quot;></i><a href=&quot;#&quot;> Ecommerce</a>
      <ul class=&quot;sidebar-dropdown list-unstyled&quot;>
        <li><a href=&quot;#&quot;>Lorem ipsum</a></li>
        <li><a href=&quot;#&quot;>ipsum dolor</a></li>
        <li><a href=&quot;#&quot;>dolor ipsum</a></li>
        <li><a href=&quot;#&quot;>amet consectetur</a></li>
        <li><a href=&quot;#&quot;>ipsum dolor sit</a></li>
      </ul>
    </li>
    <li class=&quot;has-dropdown&quot;>
      <i class=&quot;uil-bag&quot;></i><a href=&quot;#&quot;> Projects</a>
      <ul class=&quot;sidebar-dropdown list-unstyled&quot;>
        <li><a href=&quot;#&quot;>Lorem ipsum</a></li>
        <li><a href=&quot;#&quot;>ipsum dolor</a></li>
        <li><a href=&quot;#&quot;>dolor ipsum</a></li>
        <li><a href=&quot;#&quot;>amet consectetur</a></li>
        <li><a href=&quot;#&quot;>ipsum dolor sit</a></li>
      </ul>
    </li>
    <li class=&quot;&quot;>
      <i class=&quot;uil-setting&quot;></i><a href=&quot;#&quot;> Settings</a>
      <ul class=&quot;sidebar-dropdown list-unstyled&quot;>
        <li><a href=&quot;#&quot;>Lorem ipsum</a></li>
        <li><a href=&quot;#&quot;>ipsum dolor</a></li>
        <li><a href=&quot;#&quot;>dolor ipsum</a></li>
        <li><a href=&quot;#&quot;>amet consectetur</a></li>
        <li><a href=&quot;#&quot;>ipsum dolor sit</a></li>
      </ul>
    </li>
    <li class=&quot;has-dropdown&quot;>
      <i class=&quot;uil-chart-pie-alt&quot;></i><a href=&quot;#&quot;> Components</a>
      <ul class=&quot;sidebar-dropdown list-unstyled&quot;>
        <li><a href=&quot;#&quot;>Lorem ipsum</a></li>
        <li><a href=&quot;#&quot;>ipsum dolor</a></li>
        <li><a href=&quot;#&quot;>dolor ipsum</a></li>
        <li><a href=&quot;#&quot;>amet consectetur</a></li>
        <li><a href=&quot;#&quot;>ipsum dolor sit</a></li>
      </ul>
    </li>
    <li class=&quot;has-dropdown&quot;>
      <i class=&quot;uil-panel-add&quot;></i><a href=&quot;#&quot;> Charts</a>
      <ul class=&quot;sidebar-dropdown list-unstyled&quot;>
        <li><a href=&quot;#&quot;>Lorem ipsum</a></li>
        <li><a href=&quot;#&quot;>ipsum dolor</a></li>
        <li><a href=&quot;#&quot;>dolor ipsum</a></li>
        <li><a href=&quot;#&quot;>amet consectetur</a></li>
        <li><a href=&quot;#&quot;>ipsum dolor sit</a></li>
      </ul>
    </li>
    <li class=&quot;&quot;>
      <i class=&quot;uil-map-marker&quot;></i><a href=&quot;#&quot;> Maps</a>
    </li>
  </ul>
</aside>

<section id=&quot;wrapper&quot;>
  <nav class=&quot;navbar navbar-expand-md&quot;>
    <div class=&quot;container-fluid mx-2&quot;>
      <div class=&quot;navbar-header&quot;>
        <button class=&quot;navbar-toggler&quot; type=&quot;button&quot; data-bs-toggle=&quot;collapse&quot; data-bs-target=&quot;#toggle-navbar&quot; aria-controls=&quot;toggle-navbar&quot; aria-expanded=&quot;false&quot; aria-label=&quot;Toggle navigation&quot;>
          <i class=&quot;uil-bars text-white&quot;></i>
        </button>
        <a class=&quot;navbar-brand&quot; href=&quot;#&quot;>admin<span class=&quot;main-color&quot;>kit</span></a>
      </div>
      <div class=&quot;collapse navbar-collapse&quot; id=&quot;toggle-navbar&quot;>
        <ul class=&quot;navbar-nav ms-auto&quot;>
          <li class=&quot;nav-item dropdown&quot;>
            <a class=&quot;nav-link dropdown-toggle&quot; href=&quot;#&quot; id=&quot;navbarDropdown&quot; role=&quot;button&quot; data-bs-toggle=&quot;dropdown&quot; aria-expanded=&quot;false&quot;>
              Settings
            </a>
            <ul class=&quot;dropdown-menu&quot; aria-labelledby=&quot;navbarDropdown&quot;>
              <li>
                <a class=&quot;dropdown-item&quot; href=&quot;#&quot;>My account</a>
              </li>
              <li><a class=&quot;dropdown-item&quot; href=&quot;#&quot;>My inbox</a>
              </li>
              <li><a class=&quot;dropdown-item&quot; href=&quot;#&quot;>Help</a>
              </li>
              <li><hr class=&quot;dropdown-divider&quot;></li>
              <li><a class=&quot;dropdown-item&quot; href=&quot;#&quot;>Log out</a></li>
            </ul>
          </li>
          <li class=&quot;nav-item&quot;>
            <a class=&quot;nav-link&quot; href=&quot;#&quot;><i class=&quot;uil-comments-alt&quot;></i><span>23</span></a>
          </li>
          <li class=&quot;nav-item&quot;>
            <a class=&quot;nav-link&quot; href=&quot;#&quot;><i class=&quot;uil-bell&quot;></i><span>98</span></a>
          </li>
          <li class=&quot;nav-item&quot;>
            <a class=&quot;nav-link&quot; href=&quot;#&quot;>
              <i data-show=&quot;show-side-navigation1&quot; class=&quot;uil-bars show-side-btn&quot;></i>
            </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class=&quot;p-4&quot;>
    <div class=&quot;welcome&quot;>
      <div class=&quot;content rounded-3 p-3&quot;>
        <h1 class=&quot;fs-3&quot;>Welcome to Dashboard</h1>
        <p class=&quot;mb-0&quot;>Hello Jone Doe, welcome to your awesome dashboard!</p>
      </div>
    </div>

    <section class=&quot;statistics mt-4&quot;>
      <div class=&quot;row&quot;>
        <div class=&quot;col-lg-4&quot;>
          <div class=&quot;box d-flex rounded-2 align-items-center mb-4 mb-lg-0 p-3&quot;>
            <i class=&quot;uil-envelope-shield fs-2 text-center bg-primary rounded-circle&quot;></i>
            <div class=&quot;ms-3&quot;>
              <div class=&quot;d-flex align-items-center&quot;>
                <h3 class=&quot;mb-0&quot;>1,245</h3> <span class=&quot;d-block ms-2&quot;>Emails</span>
              </div>
              <p class=&quot;fs-normal mb-0&quot;>Lorem ipsum dolor sit amet</p>
            </div>
          </div>
        </div>
        <div class=&quot;col-lg-4&quot;>
          <div class=&quot;box d-flex rounded-2 align-items-center mb-4 mb-lg-0 p-3&quot;>
            <i class=&quot;uil-file fs-2 text-center bg-danger rounded-circle&quot;></i>
            <div class=&quot;ms-3&quot;>
              <div class=&quot;d-flex align-items-center&quot;>
                <h3 class=&quot;mb-0&quot;>34</h3> <span class=&quot;d-block ms-2&quot;>Projects</span>
              </div>
              <p class=&quot;fs-normal mb-0&quot;>Lorem ipsum dolor sit amet</p>
            </div>
          </div>
        </div>
        <div class=&quot;col-lg-4&quot;>
          <div class=&quot;box d-flex rounded-2 align-items-center p-3&quot;>
            <i class=&quot;uil-users-alt fs-2 text-center bg-success rounded-circle&quot;></i>
            <div class=&quot;ms-3&quot;>
              <div class=&quot;d-flex align-items-center&quot;>
                <h3 class=&quot;mb-0&quot;>5,245</h3> <span class=&quot;d-block ms-2&quot;>Users</span>
              </div>
              <p class=&quot;fs-normal mb-0&quot;>Lorem ipsum dolor sit amet</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class=&quot;charts mt-4&quot;>
      <div class=&quot;row&quot;>
        <div class=&quot;col-lg-6&quot;>
          <div class=&quot;chart-container rounded-2 p-3&quot;>
            <h3 class=&quot;fs-6 mb-3&quot;>Chart title number one</h3>
            <canvas id=&quot;myChart&quot;></canvas>
          </div>
        </div>
        <div class=&quot;col-lg-6&quot;>
          <div class=&quot;chart-container rounded-2 p-3&quot;>
            <h3 class=&quot;fs-6 mb-3&quot;>Chart title number two</h3>
            <canvas id=&quot;myChart2&quot;></canvas>
          </div>
        </div>
      </div>
    </section>

    <section class=&quot;admins mt-4&quot;>
      <div class=&quot;row&quot;>
        <div class=&quot;col-md-6&quot;>
          <div class=&quot;box&quot;>
            <!-- <h4>Admins:</h4> -->
            <div class=&quot;admin d-flex align-items-center rounded-2 p-3 mb-4&quot;>
              <div class=&quot;img&quot;>
                <img class=&quot;img-fluid rounded-pill&quot;
                     width=&quot;75&quot; height=&quot;75&quot;
                     src=&quot;https://uniim1.shutterfly.com/ng/services/mediarender/THISLIFE/021036514417/media/23148906966/small/1501685402/enhance&quot;
                     alt=&quot;admin&quot;>
              </div>
              <div class=&quot;ms-3&quot;>
                <h3 class=&quot;fs-5 mb-1&quot;>Joge Lucky</h3>
                <p class=&quot;mb-0&quot;>Lorem ipsum dolor sit amet consectetur elit.</p>
              </div>
            </div>
            <div class=&quot;admin d-flex align-items-center rounded-2 p-3 mb-4&quot;>
              <div class=&quot;img&quot;>
                <img class=&quot;img-fluid rounded-pill&quot;
                     width=&quot;75&quot; height=&quot;75&quot;
                     src=&quot;https://uniim1.shutterfly.com/ng/services/mediarender/THISLIFE/021036514417/media/23148907137/small/1501685404/enhance&quot;
                     alt=&quot;admin&quot;>
              </div>
              <div class=&quot;ms-3&quot;>
                <h3 class=&quot;fs-5 mb-1&quot;>Joge Lucky</h3>
                <p class=&quot;mb-0&quot;>Lorem ipsum dolor sit amet consectetur elit.</p>
              </div>
            </div>
            <div class=&quot;admin d-flex align-items-center rounded-2 p-3&quot;>
              <div class=&quot;img&quot;>
                <img class=&quot;img-fluid rounded-pill&quot;
                     width=&quot;75&quot; height=&quot;75&quot;
                     src=&quot;https://uniim1.shutterfly.com/ng/services/mediarender/THISLIFE/021036514417/media/23148907019/small/1501685403/enhance&quot;
                     alt=&quot;admin&quot;>
              </div>
              <div class=&quot;ms-3&quot;>
                <h3 class=&quot;fs-5 mb-1&quot;>Joge Lucky</h3>
                <p class=&quot;mb-0&quot;>Lorem ipsum dolor sit amet consectetur elit.</p>
              </div>
            </div>
          </div>
        </div>
        <div class=&quot;col-md-6&quot;>
          <div class=&quot;box&quot;>
            <!-- <h4>Moderators:</h4> -->
            <div class=&quot;admin d-flex align-items-center rounded-2 p-3 mb-4&quot;>
              <div class=&quot;img&quot;>
                <img class=&quot;img-fluid rounded-pill&quot;
                     width=&quot;75&quot; height=&quot;75&quot;
                     src=&quot;https://uniim1.shutterfly.com/ng/services/mediarender/THISLIFE/021036514417/media/23148907114/small/1501685404/enhance&quot;
                     alt=&quot;admin&quot;>
              </div>
              <div class=&quot;ms-3&quot;>
                <h3 class=&quot;fs-5 mb-1&quot;>Joge Lucky</h3>
                <p class=&quot;mb-0&quot;>Lorem ipsum dolor sit amet consectetur elit.</p>
              </div>
            </div>
            <div class=&quot;admin d-flex align-items-center rounded-2 p-3 mb-4&quot;>
              <div class=&quot;img&quot;>
                <img class=&quot;img-fluid rounded-pill&quot;
                     width=&quot;75&quot; height=&quot;75&quot;
                     src=&quot;https://uniim1.shutterfly.com/ng/services/mediarender/THISLIFE/021036514417/media/23148907086/small/1501685404/enhance&quot;
                     alt=&quot;admin&quot;>
              </div>
              <div class=&quot;ms-3&quot;>
                <h3 class=&quot;fs-5 mb-1&quot;>Joge Lucky</h3>
                <p class=&quot;mb-0&quot;>Lorem ipsum dolor sit amet consectetur elit.</p>
              </div>
            </div>
            <div class=&quot;admin d-flex align-items-center rounded-2 p-3&quot;>
              <div class=&quot;img&quot;>
                <img class=&quot;img-fluid rounded-pill&quot;
                     width=&quot;75&quot; height=&quot;75&quot;
                     src=&quot;https://uniim1.shutterfly.com/ng/services/mediarender/THISLIFE/021036514417/media/23148907008/medium/1501685726/enhance&quot;
                     alt=&quot;admin&quot;>
              </div>
              <div class=&quot;ms-3&quot;>
                <h3 class=&quot;fs-5 mb-1&quot;>Joge Lucky</h3>
                <p class=&quot;mb-0&quot;>Lorem ipsum dolor sit amet consectetur elit.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class=&quot;statis mt-4 text-center&quot;>
      <div class=&quot;row&quot;>
        <div class=&quot;col-md-6 col-lg-3 mb-4 mb-lg-0&quot;>
          <div class=&quot;box bg-primary p-3&quot;>
            <i class=&quot;uil-eye&quot;></i>
            <h3>5,154</h3>
            <p class=&quot;lead&quot;>Page views</p>
          </div>
        </div>
        <div class=&quot;col-md-6 col-lg-3 mb-4 mb-lg-0&quot;>
          <div class=&quot;box bg-danger p-3&quot;>
            <i class=&quot;uil-user&quot;></i>
            <h3>245</h3>
            <p class=&quot;lead&quot;>User registered</p>
          </div>
        </div>
        <div class=&quot;col-md-6 col-lg-3 mb-4 mb-md-0&quot;>
          <div class=&quot;box bg-warning p-3&quot;>
            <i class=&quot;uil-shopping-cart&quot;></i>
            <h3>5,154</h3>
            <p class=&quot;lead&quot;>Product sales</p>
          </div>
        </div>
        <div class=&quot;col-md-6 col-lg-3&quot;>
          <div class=&quot;box bg-success p-3&quot;>
            <i class=&quot;uil-feedback&quot;></i>
            <h3>5,154</h3>
            <p class=&quot;lead&quot;>Transactions</p>
          </div>
        </div>
      </div>
    </section>

    <section class=&quot;charts mt-4&quot;>
      <div class=&quot;chart-container p-3&quot;>
        <h3 class=&quot;fs-6 mb-3&quot;>Chart title number three</h3>
        <div style=&quot;height: 300px&quot;>
          <canvas id=&quot;chart3&quot; width=&quot;100%&quot;></canvas>
        </div>
      </div>
    </section>
  </div>
</section>
  <script src='https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.bundle.js'></script>
<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.jshttps://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js'></script>
      <script id=&quot;rendered-js&quot; >
// Other important pens.
// Map: https://codepen.io/themustafaomar/pen/ZEGJeZq
// Navbar: https://codepen.io/themustafaomar/pen/VKbQyZ

'use strict';

function $(selector) {
  return document.querySelector(selector);
}

function find(el, selector) {
  let finded;
  return (finded = el.querySelector(selector)) ? finded : null;
}

function siblings(el) {
  const siblings = [];
  for (let sibling of el.parentNode.children) {
    if (sibling !== el) {
      siblings.push(sibling);
    }
  }
  return siblings;
}

const showAsideBtn = $('.show-side-btn');
const sidebar = $('.sidebar');
const wrapper = $('#wrapper');

showAsideBtn.addEventListener('click', function () {
  $(`#${this.dataset.show}`).classList.toggle('show-sidebar');
  wrapper.classList.toggle('fullwidth');
});

if (window.innerWidth < 767) {
  sidebar.classList.add('show-sidebar');
}

window.addEventListener('resize', function () {
  if (window.innerWidth > 767) {
    sidebar.classList.remove('show-sidebar');
  }
});

// dropdown menu in the side nav
var slideNavDropdown = $('.sidebar-dropdown');

$('.sidebar .categories').addEventListener('click', function (event) {
  event.preventDefault();

  const item = event.target.closest('.has-dropdown');

  if (!item) {
    return;
  }

  item.classList.toggle('opened');

  siblings(item).forEach(sibling => {
    sibling.classList.remove('opened');
  });

  if (item.classList.contains('opened')) {
    const toOpen = find(item, '.sidebar-dropdown');

    if (toOpen) {
      toOpen.classList.add('active');
    }

    siblings(item).forEach(sibling => {
      const toClose = find(sibling, '.sidebar-dropdown');

      if (toClose) {
        toClose.classList.remove('active');
      }
    });
  } else {
    find(item, '.sidebar-dropdown').classList.toggle('active');
  }
});

$('.sidebar .close-aside').addEventListener('click', function () {
  $(`#${this.dataset.close}`).classList.add('show-sidebar');
  wrapper.classList.remove('margin');
});


// Global defaults
Chart.defaults.global.animation.duration = 2000; // Animation duration
Chart.defaults.global.title.display = false; // Remove title
Chart.defaults.global.defaultFontColor = '#71748c'; // Font color
Chart.defaults.global.defaultFontSize = 13; // Font size for every label

// Tooltip global resets
Chart.defaults.global.tooltips.backgroundColor = '#111827';
Chart.defaults.global.tooltips.borderColor = 'blue';

// Gridlines global resets
Chart.defaults.scale.gridLines.zeroLineColor = '#3b3d56';
Chart.defaults.scale.gridLines.color = '#3b3d56';
Chart.defaults.scale.gridLines.drawBorder = false;

// Legend global resets
Chart.defaults.global.legend.labels.padding = 0;
Chart.defaults.global.legend.display = false;

// Ticks global resets
Chart.defaults.scale.ticks.fontSize = 12;
Chart.defaults.scale.ticks.fontColor = '#71748c';
Chart.defaults.scale.ticks.beginAtZero = false;
Chart.defaults.scale.ticks.padding = 10;

// Elements globals
Chart.defaults.global.elements.point.radius = 0;

// Responsivess
Chart.defaults.global.responsive = true;
Chart.defaults.global.maintainAspectRatio = false;

// The bar chart
var myChart = new Chart(document.getElementById('myChart'), {
  type: 'bar',
  data: {
    labels: [&quot;January&quot;, &quot;February&quot;, &quot;March&quot;, &quot;April&quot;, 'May', 'June', 'August', 'September'],
    datasets: [{
      label: &quot;Lost&quot;,
      data: [45, 25, 40, 20, 60, 20, 35, 25],
      backgroundColor: &quot;#0d6efd&quot;,
      borderColor: 'transparent',
      borderWidth: 2.5,
      barPercentage: 0.4 },
    {
      label: &quot;Succes&quot;,
      startAngle: 2,
      data: [20, 40, 20, 50, 25, 40, 25, 10],
      backgroundColor: &quot;#dc3545&quot;,
      borderColor: 'transparent',
      borderWidth: 2.5,
      barPercentage: 0.4 }] },


  options: {
    scales: {
      yAxes: [{
        gridLines: {},
        ticks: {
          stepSize: 15 } }],


      xAxes: [{
        gridLines: {
          display: false } }] } } });






// The line chart
var chart = new Chart(document.getElementById('myChart2'), {
  type: 'line',
  data: {
    labels: [&quot;January&quot;, &quot;February&quot;, &quot;March&quot;, &quot;April&quot;, 'May', 'June', 'August', 'September'],
    datasets: [{
      label: &quot;My First dataset&quot;,
      data: [4, 20, 5, 20, 5, 25, 9, 18],
      backgroundColor: 'transparent',
      borderColor: '#0d6efd',
      lineTension: .4,
      borderWidth: 1.5 },
    {
      label: &quot;Month&quot;,
      data: [11, 25, 10, 25, 10, 30, 14, 23],
      backgroundColor: 'transparent',
      borderColor: '#dc3545',
      lineTension: .4,
      borderWidth: 1.5 },
    {
      label: &quot;Month&quot;,
      data: [16, 30, 16, 30, 16, 36, 21, 35],
      backgroundColor: 'transparent',
      borderColor: '#f0ad4e',
      lineTension: .4,
      borderWidth: 1.5 }] },


  options: {
    scales: {
      yAxes: [{
        gridLines: {
          drawBorder: false },

        ticks: {
          stepSize: 12 } }],


      xAxes: [{
        gridLines: {
          display: false } }] } } });






var chart = document.getElementById('chart3');
var myChart = new Chart(chart, {
  type: 'line',
  data: {
    labels: [&quot;One&quot;, &quot;Two&quot;, &quot;Three&quot;, &quot;Four&quot;, &quot;Five&quot;, 'Six', &quot;Seven&quot;, &quot;Eight&quot;],
    datasets: [{
      label: &quot;Lost&quot;,
      lineTension: 0.2,
      borderColor: '#d9534f',
      borderWidth: 1.5,
      showLine: true,
      data: [3, 30, 16, 30, 16, 36, 21, 40, 20, 30],
      backgroundColor: 'transparent' },
    {
      label: &quot;Lost&quot;,
      lineTension: 0.2,
      borderColor: '#5cb85c',
      borderWidth: 1.5,
      data: [6, 20, 5, 20, 5, 25, 9, 18, 20, 15],
      backgroundColor: 'transparent' },

    {
      label: &quot;Lost&quot;,
      lineTension: 0.2,
      borderColor: '#f0ad4e',
      borderWidth: 1.5,
      data: [12, 20, 15, 20, 5, 35, 10, 15, 35, 25],
      backgroundColor: 'transparent' },

    {
      label: &quot;Lost&quot;,
      lineTension: 0.2,
      borderColor: '#337ab7',
      borderWidth: 1.5,
      data: [16, 25, 10, 25, 10, 30, 14, 23, 14, 29],
      backgroundColor: 'transparent' }] },


  options: {
    scales: {
      yAxes: [{
        gridLines: {
          drawBorder: false },

        ticks: {
          stepSize: 12 } }],


      xAxes: [{
        gridLines: {
          display: false } }] } } });
//# sourceURL=pen.js
    </script>

  
</body>

</html>
"
      sandbox="allow-forms allow-modals allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-top-navigation-by-user-activation allow-downloads allow-presentation" allow="accelerometer; camera; encrypted-media; display-capture; geolocation; gyroscope; microphone; midi; clipboard-read; clipboard-write; web-share" allowTransparency="true"
      allowpaymentrequest="true" allowfullscreen="true" class="result-iframe">
      </iframe>
  </div>

</body>

</html>
