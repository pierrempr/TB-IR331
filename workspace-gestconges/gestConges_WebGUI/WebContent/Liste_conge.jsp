<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="gestConges.front.utils.*,
                java.util.*"%>
<%@page import="gestConges.data.model.Conge"%>
<%@page import="gestConges.service.IGestionConges"%>
<%@page import="gestConges.data.model.Salarie"%>
<%@page import="gestConges.service.IGestionSalarie"%>

<%
String idString = request.getParameter("id_salarie");
// R�cup�ration du service
IGestionConges gestionConges = (IGestionConges) ServicesLocator.getInstance().getRemoteInterface("GestionConges");
//IServiceSecteurActivite secteurActivite = (IServiceSecteurActivite) ServicesLocator.getInstance().getRemoteInterface("ServiceSecteur");

List<Conge> conges = gestionConges.listeDesOffresPourUnSalarie(Integer.parseInt(idString));
%>

<html>
	<head>
    	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    	<title>Logiciel de conges :</title>
    	<link rel="stylesheet" href="styles.css" type="text/css" />
  	</head>

  	<body>
  
		<h2>Liste des cong�s</h2>
		<table id="affichage" border="1" >
  			<tr BGCOLOR=GRAY style ="color: WHITE; font-size: medium; font-family: Arial">
		    <th>Status</th>
		    <th>Periode</th>
		    <th>D�but </th>
		    <th>Fin</th>
		    <th>Action</th>
		  </tr>
  			<%
  			for (Conge conge : conges){
  				
  			%>
  			<tr <%if(conge.getStatus().equals("Valide RH")){%>style ="color: black; background-color : #99CC99" <%}%>
  			    <%if(conge.getStatus().equals("Non authorise N+1") || conge.getStatus().equals("Non valide RH")){%>style ="color: black; background-color : #FF9999"<%}%>
  			    <%if(conge.getStatus().equals("Authorise N+1")){%>style ="color: black; background-color : #FFCC99" <%}%>
  			>
  				<td><%= conge.getStatus()%></td>
  				<td><%= conge.getPeriode()%></td>
  				<td><%= conge.getDebutconges()%></td>
  				<td><%= conge.getFinconges()%></td>
  				<td>
  				<%if(conge.getStatus().equals("cree")){%>
  				<a href="template.jsp?action=supprimer_conge&id_conges=<%=conge.getId()%>" onclick="return confirm('�tes-vous s�r de vouloir retirer votre conges ?\n\nAttention, cette op�ration n\'est pas r�versible !\n\n');"><p>Annuler cong�s</p> </a>
  				<%}%>
  			 	<% if(conge.getStatus().equals("Non authorise N+1")){%>
  				<a href="template.jsp?action=retirer_conge&id_conges=<%=conge.getId()%>" onclick="return confirm('�tes-vous s�r de vouloir retirer votre conges ?\n\nAttention, cette op�ration n\'est pas r�versible !\n\n');"><p>Retirer cong�s de la liste</p> </a>
  				<%}%>
  				<% if(conge.getStatus().equals("Authorise N+1")){%>
  				<a href="template.jsp?action=supprimer_conge&id_conges=<%=conge.getId()%>" onclick="return confirm('�tes-vous s�r de vouloir retirer votre conges ?\n\nAttention, cette op�ration n\'est pas r�versible !\n\n');"><p>Annuler cong�s</p> </a>
  				<%}%>
  				<% if(conge.getStatus().equals("Non valide RH")){%>
  				<a href="template.jsp?action=retirer_conge&id_conges=<%=conge.getId()%>" onclick="return confirm('�tes-vous s�r de vouloir retirer votre conges ?\n\nAttention, cette op�ration n\'est pas r�versible !\n\n');"><p>Retirer cong�s de la liste</p> </a>
  				<%}%>
  				<% if(conge.getStatus().equals("Valide RH")){%>
  				<a href="template.jsp?action=supprimer_conge&id_conges=<%=conge.getId()%>" onclick="return confirm('�tes-vous s�r de vouloir retirer votre conges ?\n\nAttention, cette op�ration n\'est pas r�versible !\n\n');"><p>Annuler cong�s</p> </a>
  				<%}%>
  				</td>
  			</tr>	
  			<%
  			}
  			%>

		</table>
    	<p><a href="index.jsp">Retour au menu</a></p>
  	</body>
</html>