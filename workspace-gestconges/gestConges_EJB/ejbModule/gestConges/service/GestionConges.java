package gestConges.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import gestConges.data.dao.CongeDAO;
import gestConges.data.model.Conge;
import gestConges.data.dao.SalarieDAO;
import gestConges.data.model.Salarie;

/**
 * Session Bean implementation class GestionConges
 */
@Stateless
@LocalBean
public class GestionConges implements IGestionConges {
	@EJB
	private CongeDAO congeDAO;
	@EJB
	private SalarieDAO salarieDAO;
    /**
     * Default constructor. 
     */
    public GestionConges() {
        // TODO Auto-generated constructor stub
    }
    
	@Override
	public Conge getConges(int id)
	{
		return congeDAO.findById(id);
	}
    
    @Override
    public List<Conge> listeConge(){
    	return congeDAO.findAll();
    }
    
    @Override
    public Conge addConge(int ids, String status, String debutconges, String finconges,double periode){
    	Conge myConge = new Conge();
    	myConge.setIdemploye(ids);
    	myConge.setStatus(status);
    	myConge.setDebutconges(debutconges);
    	myConge.setFinconges(finconges);
        myConge.setPeriode(periode);
         
        congeDAO.create(myConge);
         
    	return congeDAO.update(myConge);
    }
    
    public boolean isAlphaNumeric(String s){
        String pattern= "^[a-zA-Z0-9]*$";
            if(s.matches(pattern)){
                return true;
            }
            return false;   
    }
    
    @Override
    public double calculPeriode(String debutconges, String finconges){
    	
    	//System.out.println("La date de debut : " + debutconges);
    	//System.out.println("La date de fin : " + finconges);
    	
    	String[] debutCoupe = debutconges.split("/");
    	//System.out.println("date début découpe" + debutCoupe[0] + " [d1] : " + debutCoupe[1] + " [d2] : " + debutCoupe[2]);
    	String[] finCoupe = finconges.split("/");
    	//System.out.println("date fin découpe [0] " + finCoupe[0] + " [f1] : " +  finCoupe[1] + " [f2] : " + finCoupe[2]);
    	
    	//comptage de la période5
    	 int compteur = 0;
         Calendar calendar1 = new GregorianCalendar();
         calendar1.set(Calendar.YEAR, Integer.parseInt(debutCoupe[2]));
         calendar1.set(Calendar.MONTH, Integer.parseInt(debutCoupe[1])-1);
         calendar1.set(Calendar.DAY_OF_MONTH, Integer.parseInt(debutCoupe[0]));
         Date date1 = calendar1.getTime();
  
         //  2006-08-15
         Calendar calendar2 = new GregorianCalendar();
         calendar2.set(Calendar.YEAR, Integer.parseInt(finCoupe[2]));
         calendar2.set(Calendar.MONTH, Integer.parseInt(finCoupe[1])-1);
         calendar2.set(Calendar.DAY_OF_MONTH, Integer.parseInt(finCoupe[0]));
         Date date2 = calendar2.getTime();
  
         // Différence
         long diff = Math.abs(date2.getTime() - date1.getTime());
         long numberOfDay = (long)diff/86400000;
         int jourferie =0;
          for(int i=0;i<=numberOfDay;i++){
        	  jourferie =100*(calendar1.get(Calendar.MONTH)+1)+calendar1.get(Calendar.DAY_OF_MONTH);
              if(calendar1.get(Calendar.DAY_OF_WEEK) != Calendar.SATURDAY && calendar1.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY && jourferie!=101 && jourferie!=501 && jourferie!=508 && jourferie!=501 && jourferie!=714 && jourferie!=815 && jourferie!=111 && jourferie!=1111 && jourferie!=1225){
            	  compteur = compteur + 1;
                }
             // System.out.println("jour de la semaine : " + (Integer.parseInt(debutCoupe[0])+i) +" + " + calendar1.get(Calendar.DAY_OF_WEEK)  + "le compteur = " + compteur);
              calendar1.add(Calendar.DAY_OF_MONTH, 1);
          }
         System.out.println("Le nombre de jour ouvrés est : " + compteur); 
         
    	return compteur;
    }
    
public int calculDateValide(String debutconges, String finconges){
    	
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
		Date date = new Date();
		System.out.println(dateFormat.format(date));
		String test = dateFormat.format(date);
    	String[] debutCoupe = debutconges.split("/");
    	String[] finCoupe = finconges.split("/");
    	String[] dateCoupe = test.split("/");
    	//String timeStamp = new SimpleDateFormat("dd/mm/yyyy").format(Calendar.getInstance());
    	
    	int dateFin, dateDebut,datePresent;
    	int compteur = 0;
    	
    	
    	dateDebut = (10000*Integer.parseInt(debutCoupe[2])+ 100*Integer.parseInt(debutCoupe[1])+ Integer.parseInt(debutCoupe[0]));
    	System.out.println("date début calculé" + dateDebut);
    	dateFin = (10000*Integer.parseInt(finCoupe[2])+ 100*Integer.parseInt(finCoupe[1])+ Integer.parseInt(finCoupe[0]));
    	System.out.println("date fin calcule " + dateFin);
    	datePresent = (10000*Integer.parseInt(dateCoupe[2])+ 100*Integer.parseInt(dateCoupe[1])+ Integer.parseInt(dateCoupe[0]));
    	System.out.println("date present calcule " + datePresent);
    	int resultat = dateFin - dateDebut;
    	System.out.println("resultat " + resultat);
    	int resultat2 = dateDebut - datePresent;
    	System.out.println("resultat2 " + resultat2);
    	if(resultat<0){
        	if(resultat2<0){
        		//date de début antérieur à la date présente
        		compteur =3;
        	}
        	else{
        		////date de fin antérieur à la date de début
        		compteur = 2;
        	}
    	}
    	else if(resultat>=0){
        	if(resultat2<0){
        		//date de début antérieur à la date présente
        		compteur =3;
        	}
        	else{
        		//tout est ok
        		compteur = 1;
        	}
    	}
    
    	return compteur;
    }
    
    
    @Override
    public List<Conge> listeDesOffresPourUnSalarie(int id){
    	return congeDAO.findCongeById(id);
    }
    
	@Override
	public void miseAJour(Conge c) {
		congeDAO.update(c);
	}

    public void deleteConge(int id){
    	congeDAO.remove(getConges(id));
    }

}
