<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="gestConges.front.utils.*,
                java.util.*"%>
<%@page import="gestConges.data.model.Conge"%>
<%@page import="gestConges.service.IGestionConges"%>
<%@page import="gestConges.data.model.Salarie"%>
<%@page import="gestConges.service.IGestionSalarie"%>

<%
String idConge = request.getParameter("id_conge");

// Récupération du servicecongés
IGestionConges gestionConges = (IGestionConges) ServicesLocator.getInstance().getRemoteInterface("GestionConges");
IGestionSalarie gestionSalarie = (IGestionSalarie) ServicesLocator.getInstance().getRemoteInterface("GestionSalarie");

Conge c = gestionConges.getConges(Integer.parseInt(idConge));
String status = "Valide RH";
c.setStatus(status);
gestionConges.miseAJour(c);

int id_salarie = c.getIdemploye();
Salarie s = gestionSalarie.getSalarie(id_salarie);

double solde = s.getSolde();
double periode = gestionConges.calculPeriode(c.getDebutconges(), c.getFinconges());
double resultat = solde-periode;

s.setSolde(resultat);
gestionSalarie.miseAJour(s);

%>
<html>

  	<head>
    	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    	<link rel="stylesheet" href="styles.css" type="text/css" />
  	</head>
  
  	<body>
  		<%
  		
  	//session.invalidate();
	//response.sendRedirect("liste_offre_entreprise.jsp");
		%>
		<META HTTP-EQUIV="Refresh" CONTENT="2; index.jsp">
  		<h2>Validé RH</h2>
  		<%response.sendRedirect("template.jsp?action=Liste_collaborateur");%>
  		<p><a href="index.jsp">Retour au menu</a></p>
  		
 	</body>
</html>