<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
                
<%@page import="gestConges.front.utils.ServicesLocator,
                gestConges.service.*,
                gestConges.data.model.*,
                java.util.*"%>    
       
<%
//Recherche de l'entreprise connecte
Object utilisateur = session.getAttribute("utilisateur");
int idConge = Integer.parseInt(request.getParameter("id_conges"));

Salarie s = (Salarie) utilisateur;
int id_salarie = s.getId();
double newSolde = 0;

// Recuperation du service
IGestionConges gestionConges = (IGestionConges) ServicesLocator.getInstance().getRemoteInterface("GestionConges");
IGestionSalarie gestionSalarie = (IGestionSalarie) ServicesLocator.getInstance().getRemoteInterface("GestionSalarie");
List<Conge> conges = gestionConges.listeDesOffresPourUnSalarie(id_salarie);

//Suppression des conges au salarie 
for(Conge conge : conges) {
	if(conge.getId() == idConge){
		gestionConges.deleteConge(conge.getId());
		/*if(conge.getStatus().equals("Valide RH")){
		newSolde = s.getSolde() + conge.getPeriode();
		s.setSolde(newSolde);
		gestionSalarie.miseAJour(s);
		}*/
	}
}

%>
<html>

  	<head>
    	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    	<title>Retirer conges</title>
    	<link rel="stylesheet" href="styles.css" type="text/css" />
  	</head>
  
  	<body>
  		<%
  		
  	//session.invalidate();
	//response.sendRedirect("liste_offre_entreprise.jsp");
		%>
		<META HTTP-EQUIV="Refresh" CONTENT="2; index.jsp"> 
  		<h2>Conge retirer !!</h2>
  		<p> Vous allez �tre redirig� vers la page d'acceuil </p>
  		<p><a href="index.jsp">Retour au menu</a></p>
  		
 	</body>
</html>