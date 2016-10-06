package br.com.draftfcb.hp.cartuchopirata {
	
	import caurina.transitions.properties.ColorShortcuts;
	import caurina.transitions.properties.DisplayShortcuts;
	
	import br.com.draftfcb.hp.cartuchopirata.menu.basic.*;
	import br.com.draftfcb.hp.cartuchopirata.loading.basic.*;
	
	import br.com.draftfcb.hp.cartuchopirata.pages.*;
	
	import com.avmvc.avMvc;
	import com.avmvc.interfaces.IConfig;
	import com.avmvc.view.avMvcText;

	/**
	 * <b>Author:</b> Allan Avelar<br />
	 */
	
	public class Config implements IConfig {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _siteName:String;
		private var _landingPageID:String;
		private var _loadingClass:String;
		private var _menuClass:String;
		private var _params:Object;

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Config() {}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function registerClasses():void {
			avMvc.getInstance().registerClass(Home);
			avMvc.getInstance().registerClass(Produtos);
			avMvc.getInstance().registerClass(Desculpas);
			avMvc.getInstance().registerClass(Campanha);
			avMvc.getInstance().registerClass(VideoCampanha);
			avMvc.getInstance().registerClass(BasicLoading);
			avMvc.getInstance().registerClass(BasicMenu);
		}

		// PUBLIC
		//________________________________________________________________________________________________

		public function init():void {
			_siteName = "DraftFCB";
			_loadingClass = "BasicLoading";
			_menuClass = "BasicMenu";
			_landingPageID = "";
			_params = {};
			
			avMvcText.DEFAULT_EMBED_FONT = true;
			avMvcText.DEFAULT_CONDENSE_WHITE = true;
			XML.ignoreWhitespace = true;
			registerClasses();
			// tweener settings
			DisplayShortcuts.init();
			ColorShortcuts.init();
		}

		public function get loadingClassName():String {
			return _loadingClass;
		}
		
		public function get menuClassName():String {
			return _menuClass;
		}
		
		public function get siteName():String {
			return _siteName;
		}
		
		public function get landingPageID():String {
			return _landingPageID;
		}
		
		public function set params(o:Object):void {
			_params = o;
		}
		public function get params():Object {
			return _params;
		}
		
		protected const Author	:String = 'Allan Avelar';
		protected const Email	:String = 'contato@allanavelar.com.br';
	}
}
