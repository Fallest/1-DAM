import java.awt.event.ActionEvent;
import java.io.IOException;

import javax.swing.JOptionPane;

public interface InterfaceVentanaDepart {
	public void modificar(ActionEvent e, String existedepart) {
		int dep;
		int confirm;
		if (e.getSource() == modif) { //SE PULSA EL BOTON  modificar  	
			mensaje.setText(" has pulsado el boton Modificar.");   
			try {
		    	  dep=Integer.parseInt(num.getText());
		    	  if (dep >0)
		    	      if (consultar(dep))
		    	       { mensaje.setText(existedepart);  
		    	         confirm=JOptionPane.showConfirmDialog(this, "ESTAS SEGURO DE MODIFICAR...", "AVISO MODIFICACIÔøΩN.", 
		    	        		     JOptionPane.OK_CANCEL_OPTION);	  
		    	           // si devuelve 0 es OK
		    	           //mensaje.setText(" has pulsado el boton Borrar "+ confirm);   
		    	        if (confirm==0)  
		    	          { modificar(dep);
		    	            mensaje.setText(" REGISTRO MODIFICADO: " + dep);	
			 	           }
		    	       } 
				      else
						{ mensaje.setText(nOEXISTEDEPART);	
						  nombre.setText(" "); loc.setText(" ");
		    	         }
		    	  else mensaje.setText("DEPARTAMENTO DEBE SER MAYOR QUE 0");	
		    	  
		       } catch(java.lang.NumberFormatException ex) //controlar el error del Integer.parseInt
		           {mensaje.setText("DEPARTAMENTO ERRÔøΩNEO");} 
		       catch (IOException ex2) 
		    	   {mensaje.setText(" ERRORRR EN EL FICHERO. Fichero no existe. (MODIFICAR)");} 
		    }
	}

	public void borrar(ActionEvent e, String existedepart) {
		int dep;
		int confirm;
		if (e.getSource() == borra) { //SE PULSA EL BOTON  borrar  	
			mensaje.setText(" has pulsado el boton Borrar");   
			try {
		    	  dep=Integer.parseInt(num.getText());
		    	  if (dep >0)
		    	      if (consultar(dep))
		    	       { mensaje.setText(existedepart);   
		    	         visualiza(dep);
		    	         confirm=JOptionPane.showConfirmDialog(this, "ESTAS SEGURO DE BORRAR...", "AVISO BORRADO.", 
		    	        		     JOptionPane.OK_CANCEL_OPTION);	  
		    	           // si devuelve 0 es OK
		    	           //mensaje.setText(" has pulsado el boton Borrar "+ confirm);   
		    	         if (confirm==0)  
		    	          { borrar(dep);
		    	            mensaje.setText(" REGISTRO BORRADOO: " + dep);	
						    nombre.setText(" "); loc.setText(" ");
		    	           }
		    	       } 
				      else
						{ mensaje.setText(nOEXISTEDEPART);	
						  nombre.setText(" "); loc.setText(" ");
		    	         }
		    	  else mensaje.setText("DEPARTAMENTO DEBE SER MAYOR QUE 0");	
		    	  
		       } catch(java.lang.NumberFormatException ex) //controlar el error del Integer.parseInt
		           {mensaje.setText("DEPARTAMENTO ERRÔøΩNEO");} 
		       catch (IOException ex2) 
		    	   {mensaje.setText("ERRORRR EN EL FICHERO. Fichero no existe. (BORRAR)");} 
		    }
	}

	public void consultar(ActionEvent e, String existedepart) {
		int dep;
		nOEXISTEDEPART = "DEPARTAMENTO NO EXISTE.";
		if (e.getSource() == consu) { //SE PULSA EL BOTON  consultar  	
			mensaje.setText(" has pulsado el boton alta");   
			try {
		    	  dep=Integer.parseInt(num.getText());
		    	  if (dep >0)
		    	      if (consultar(dep))
		    	       { mensaje.setText(existedepart);   
		    	         visualiza(dep);}
				      else
						{ mensaje.setText(nOEXISTEDEPART);	
						  nombre.setText(" "); loc.setText(" ");
		    	         }
		    	  else mensaje.setText("DEPARTAMENTO DEBE SER MAYOR QUE 0");	
		    	  
		       } catch(java.lang.NumberFormatException ex) //controlar el error del Integer.parseInt
		           {mensaje.setText("DEPARTAMENTO ERRÔøΩNEO");}
		         catch (IOException ex2) 
	    	      {mensaje.setText(" ERRORRR EN EL FICHERO. Fichero no existe. (ALTA)");} 
		      
		    }
	}

	public void insertarDepartamento(ActionEvent e, String existedepart, String prueba) {
		int dep;
		if (e.getSource() == balta) { //SE PULSA EL BOTON alta   	
			mensaje.setText(" has pulsado el boton alta");   
			try {
		    	  dep=Integer.parseInt(num.getText());
		    	  if (dep >0)
		    	      if (consultar(dep))
						 mensaje.setText(existedepart);   
				      else
						{ mensaje.setText("NUEVO DEPARTAMENTO.");	
		    	          grabar(dep, nombre.getText(), loc.getText());
		    	          mensaje.setText("NUEVO DEPARTAMENTO GRABADO.");	
		    	         }
		    	  else mensaje.setText("DEPARTAMENTO DEBE SER MAYOR QUE 0");	
		    	  
		       } catch(java.lang.NumberFormatException ex) //controlar el error del Integer.parseInt
		         {depar_error = "DEPARTAMENTO ERRÛNEO.";
				mensaje.setText(depar_error);} 
		       catch (IOException ex2) {
		    	   mensaje.setText("ERRORRR EN EL FICHERO. Fichero no existe. (ALTA)");
		    	   // lo creo
		    		
		    		
		    		 } 
		    }
	}
}
