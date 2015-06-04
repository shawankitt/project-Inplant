package hibernate.pojo;
// Generated 3 Jun, 2015 5:12:49 PM by Hibernate Tools 4.3.1


import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

/**
 * TblProcess generated by hbm2java
 */
public class TblProcess  implements java.io.Serializable {


     private BigDecimal IProcessId;
     private TblPlant tblPlant;
     private String TProcessType;
     private Set<TblMapping> tblMappings = new HashSet<TblMapping>(0);

    public TblProcess() {
    }

	
    public TblProcess(BigDecimal IProcessId, TblPlant tblPlant) {
        this.IProcessId = IProcessId;
        this.tblPlant = tblPlant;
    }
    public TblProcess(BigDecimal IProcessId, TblPlant tblPlant, String TProcessType, Set<TblMapping> tblMappings) {
       this.IProcessId = IProcessId;
       this.tblPlant = tblPlant;
       this.TProcessType = TProcessType;
       this.tblMappings = tblMappings;
    }
   
    public BigDecimal getIProcessId() {
        return this.IProcessId;
    }
    
    public void setIProcessId(BigDecimal IProcessId) {
        this.IProcessId = IProcessId;
    }
    public TblPlant getTblPlant() {
        return this.tblPlant;
    }
    
    public void setTblPlant(TblPlant tblPlant) {
        this.tblPlant = tblPlant;
    }
    public String getTProcessType() {
        return this.TProcessType;
    }
    
    public void setTProcessType(String TProcessType) {
        this.TProcessType = TProcessType;
    }
    public Set<TblMapping> getTblMappings() {
        return this.tblMappings;
    }
    
    public void setTblMappings(Set<TblMapping> tblMappings) {
        this.tblMappings = tblMappings;
    }




}

