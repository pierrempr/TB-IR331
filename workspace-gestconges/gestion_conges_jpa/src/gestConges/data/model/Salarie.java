package gestConges.data.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the salarie database table.
 * 
 */
@Entity
@NamedQuery(name="Salarie.findAll", query="SELECT s FROM Salarie s")
public class Salarie implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="SALARIE_ID_GENERATOR", sequenceName="SALARIE_ID_SEQ",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="SALARIE_ID_GENERATOR")
	private Integer id;

	private Boolean isemploye;

	private Boolean ismanager;

	private Boolean isrh;

	private String nom;

	private String password;

	private String prenom;

	private String pseudo;

	private double solde;
	
	private double soldePrev;
	
	private Integer idmanager;

	public Salarie() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Boolean getIsemploye() {
		return this.isemploye;
	}

	public void setIsemploye(Boolean isemploye) {
		this.isemploye = isemploye;
	}

	public Boolean getIsmanager() {
		return this.ismanager;
	}

	public void setIsmanager(Boolean ismanager) {
		this.ismanager = ismanager;
	}

	public Boolean getIsrh() {
		return this.isrh;
	}

	public void setIsrh(Boolean isrh) {
		this.isrh = isrh;
	}

	public String getNom() {
		return this.nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPrenom() {
		return this.prenom;
	}

	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}

	public String getPseudo() {
		return this.pseudo;
	}

	public void setPseudo(String pseudo) {
		this.pseudo = pseudo;
	}

	public double getSolde() {
		return this.solde;
	}

	public void setSolde(double solde) {
		this.solde = solde;
	}


	public Integer getIdmanager() {
		return idmanager;
	}

	public void setIdmanager(Integer idmanager) {
		this.idmanager = idmanager;
	}

	public double getSoldePrev() {
		return soldePrev;
	}

	public void setSoldePrev(double soldePrev) {
		this.soldePrev = soldePrev;
	}

}