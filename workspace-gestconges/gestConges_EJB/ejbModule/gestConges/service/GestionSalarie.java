package gestConges.service;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import gestConges.data.dao.CongeDAO;
import gestConges.data.model.Conge;
import gestConges.data.dao.SalarieDAO;
import gestConges.data.model.Salarie;


/**
 * Session Bean implementation class GestionSalarie
 */

@Stateless
@LocalBean
public class GestionSalarie implements IGestionSalarie {
	@EJB
	private CongeDAO congeDAO;
	@EJB
	private SalarieDAO salarieDAO;
	
    /**
     * Default constructor. 
     */
    public GestionSalarie() {
        // TODO Auto-generated constructor stub
    }
    
    @Override
    public List<Salarie> listeSalaries(){
    	return salarieDAO.findAll();
    }

	@Override
	public Salarie getSalarie(int id) {
		// TODO Auto-generated method stub
		return salarieDAO.findById(id);
	}
    
	@Override
	public void miseAJour(Salarie s) {
		// TODO Auto-generated method stub
		salarieDAO.update(s);
	}
	
	@Override
	public List<Salarie> listeDesSalariesPourUnManager(int id) {
		// TODO Auto-generated method stub
		return salarieDAO.findSalarieByIdManager(id);
	}
}
