package br.com.draftfcb.hp.cartuchopirata.menu.basic {
	
	import com.avmvc.interfaces.IMenu;
	import com.avmvc.view.Menu;		

	/**
	 * <b>Author:</b> Allan Avelar<br />
	 */
	
	public class BasicMenu extends Menu implements IMenu {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public var xml:XML;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function BasicMenu() {
			init();
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function init():void { }
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function openMenu(id:String):void { }
		
	}
	
}
