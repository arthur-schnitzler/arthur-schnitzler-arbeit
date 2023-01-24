<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xsl tei xs" version="2.0">
    <xsl:template match="/" name="nav_bar">
        <div class="wrapper-fluid wrapper-navbar sticky-navbar" id="wrapper-navbar" itemscope="" itemtype="http://schema.org/WebSite">
            <a class="skip-link screen-reader-text sr-only" href="#content">Zum Inhalt</a>
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="container-fluid">
                    <!-- Your site title as branding in the menu -->
                    <a href="index.html" class="navbar-brand custom-logo-link" rel="home" itemprop="url">
                        <img src="https://shared.acdh.oeaw.ac.at//schnitzler-briefe/project-logo.svg" class="img-fluid" alt="schnitzler-briefe" itemprop="logo"/>
                    </a><!-- end custom logo -->
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"/>
                    </button>
                    <div class="collapse navbar-collapse justify-content-end" id="navbarNavDropdown">
                        <!-- Your menu goes here -->
                        <ul id="main-menu" class="navbar-nav">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Projekt
                                </a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="about.html">Zum Projekt</a>
                                    <a class="dropdown-item" href="projektstatus.html">Projektstatus</a>
                                    <a class="dropdown-item" href="editionsrichtlinien.html">Editionsrichtlinien</a>
                                    <a class="dropdown-item" href="danksagung.html">Danksagung</a>
                                    <a class="dropdown-item" href="kooperationen.html">Kooperationen</a>
                                    <div class="dropdown-divider"/>
                                    <a class="dropdown-item" href="drucke.html">Gedruckte Briefwechsel</a>
                                    <a class="dropdown-item" href="andere-drucke.html">Weitere Druckdigitalisate</a>
                                    <a class="dropdown-item" href="gedruckte-korrespondenz.html">Korrespondenz-Bibliografie</a>
                                </div>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="calendar.html">Kalender</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Index
                                </a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="listperson.html">Personen</a>
                                    <a class="dropdown-item" href="listwork.html">Werke</a>
                                    <a class="dropdown-item" href="listplace.html">Orte</a>
                                    <a class="dropdown-item" href="listorg.html">Institutionen</a>
                                </div>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Briefe
                                </a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="toc.html">Briefe</a>
                                    <a class="dropdown-item" href="toc-correspondences.html">Korrespondenzen</a>
                                    <a class="dropdown-item" href="toc-versand.html">Versand</a>
                                    <a class="dropdown-item" href="toc-empfang.html">Empfang</a>
                                    <a class="dropdown-item" href="toc-archive.html">Archive</a>
                                </div>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Technisches
                                </a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="elemente.html">Verwendete Elemente</a>
                                </div>
                            </li>
                            
                            <!--<li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    API
                                </a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="../api/api.html">API</a>
                                    <a class="dropdown-item" href="../analyze/beacon.xql">GND-Beacon</a>
                                </div>
                            </li>-->
                        </ul>
                        <a href="search.html">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search">
                                    <circle cx="11" cy="11" r="8"/>
                                    <line x1="21" y1="21" x2="16.65" y2="16.65"/>
                                </svg>
                            SUCHE
                        </a>
                    </div>
                    <!-- .collapse navbar-collapse -->
                </div>
                <!-- .container -->
            </nav>
            <!-- .site-navigation -->
        </div>
    </xsl:template>
</xsl:stylesheet>