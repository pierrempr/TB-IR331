
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="gestConges.front.utils.ServicesLocator,
                gestConges.service.*,
                gestConges.data.model.*,
                java.util.*"%>               
<%
SimpleDateFormat dateConv = new SimpleDateFormat("dd/MM/yyyy");
//obligatoire
String debutconges = request.getParameter("debutconges");
String finconges = request.getParameter("finconges");

Object utilisateur = session.getAttribute("utilisateur");
Salarie s = (Salarie) utilisateur;
int id_sal = s.getId();
double soldePrev,periode,resultat;
soldePrev = s.getSoldePrev();

%>
                
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Traitement cr�ation candidature</title>
<link rel="stylesheet" href="styles.css" type="text/css" />
</head>
<body>
                   	<%
                        if( debutconges.equals("") ){
                    %>
							<div class="erreur">    
  							<label >Le champ debutconges n'est pas rempli! Veuillez rentrez une date de d�but</label>    
							<p><a href="index.jsp">Retour au menu</a></p>
							</div>  
					<%
                        }else if( finconges.equals("") ){
                    %>
							<div class="erreur">    
  							<label >Le champ finconges n'est pas rempli! Veuillez rentrez une date de fin</label>  
							<p><a href="index.jsp">Retour au menu</a></p>
							</div> 
					<%
                        }else {
								
                                // Recuperation du service (bean session)
                                IGestionConges gestionConges = (IGestionConges) ServicesLocator.getInstance().getRemoteInterface("GestionConges");
                                IGestionSalarie gestionSalarie = (IGestionSalarie) ServicesLocator.getInstance().getRemoteInterface("GestionSalarie");
                                int ok = gestionConges.calculDateValide(debutconges, finconges);
                                System.out.printf("ok :" + ok);
                                int ids;
                                ids = id_sal;
                                
                                String status;
                                status = "cree" ;
                                String statusN;
                                statusN = "Authorise N+1" ;
                                
                                Conge conge;
                                
                                periode = gestionConges.calculPeriode(debutconges, finconges);
                                resultat = soldePrev-periode;
                                if(resultat >=0){
                                	if(s.getId()!=s.getIdmanager()){
                                conge = gestionConges.addConge(ids, status, debutconges,finconges,periode);
                                	}
                                	else{
                                        conge = gestionConges.addConge(ids, statusN, debutconges,finconges,periode);
                                    }
                                s.setSoldePrev(resultat);
                                gestionSalarie.miseAJour(s);
                                %>

                                <h2>Recapitulatif du cong�s <%=conge.getId()%> :</h2>
			   						<p><u>d�but du cong�:</u> <%=conge.getDebutconges()%></p>  
                                <p><u>Fin du cong�s :</u> <%=conge.getFinconges()%></p>  
                                <p><u>P�riode :</u><%=conge.getPeriode()%></p>  
                                <p><u>Status :</u> <%=conge.getStatus()%></p>  
                                <%
                                }
                                else{
                                	%>
                                	<p> Si toute vos demande decong�s sont valid�s par le RH.</p>
                                	<p> Votre Futur solde est inf�rieur au nombre de jour demand� </p>
                                	<p><a href="template.jsp?action=nouveau_conges">Retour � la demande de conges</a></p> 
                                <%
                                }
                                %>
                                
                        <p><a href="index.jsp">Retour au menu</a></p> 
                        <% 
                        } 
                        %>

</body>
</html>