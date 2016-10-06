package br.com.draftfcb.hp.cartuchopirata {
	
	import br.com.draftfcb.hp.cartuchopirata.pages.controls.CampanhaControl;
	import br.com.draftfcb.hp.cartuchopirata.pages.controls.DesculpasControl;
	import br.com.draftfcb.hp.cartuchopirata.pages.controls.DestaqueControl;
	import br.com.draftfcb.hp.cartuchopirata.pages.controls.HeaderControl;
	import br.com.draftfcb.hp.cartuchopirata.pages.controls.PeelControl;
	import br.com.draftfcb.hp.cartuchopirata.pages.controls.ProdutosControl;
	
	import com.adobe.serialization.json.JSON;
	import com.avmvc.avMvc;
	import com.avmvc.events.ContentEvent;
	import com.avmvc.events.avMvcEvent;
	import com.avmvc.loader.avMvcLoaderEvent;
	import com.debug.arthropod.Debug;
	import com.pixelbreaker.ui.osx.MacMouseWheel;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;

	/**
	 * <b>Author:</b> Allan Avelar<br />
	 */
	 
	public class Main extends Sprite {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var site:homepage;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		

		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Main() {
			Security.allowInsecureDomain("*");
			Security.allowDomain("*");
			addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true);
			init();
		}

		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function init():void {
			// listeners
			avMvc.getInstance().addEventListener(ContentEvent.LOADED, contentLoaded);
			avMvc.getInstance().addEventListener(avMvcEvent.INITIALIZED, initialized);
			// stylesheet
			avMvc.getInstance().registerGloBalStyleSheet("css/flash_global.css");
			// start
			avMvc.getInstance().start(this, "data/site.xml", new Config());
		}
		
		private function added(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added, false);
			MacMouseWheel.setup(stage);
		}
		
		private function contentLoaded(e:ContentEvent = null):void {
			// XML and CSS loaded
		}

		private function initialized(e:avMvcEvent = null):void {
			site = new homepage(); site.name = "site";
			avMvc.getInstance().container.addChildAt(site, 0);
			
			stage.addEventListener( Event.RESIZE, onResize ); onResize();
			
			avMvc.getInstance().loader.addEventListener(avMvcLoaderEvent.COMPLETE, itensComplete);
			avMvc.getInstance().loader.add("internas/config.txt");
			avMvc.getInstance().loader.start();
		}
		
		private function loadConfig(event:avMvcLoaderEvent):void {
			var source:String = event.item.file;
			avMvc.getInstance().config.params = JSON.decode(source,false);
			loadHeader();
		}

		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		private function loadPeel():void {
			try{
				Debug.log ( this + ">>loadPeel()" );
				avMvc.getInstance().loader.add("internas/peel.swf");
				avMvc.getInstance().loader.start();
			} catch(e:Error) {
				Debug.log("loadPeelError: " + e);
			}
		}
		
		private function loadHeader():void {
			try{
				Debug.log ( this + ">>loadHeader()" );
				avMvc.getInstance().loader.add("internas/header.swf");
				avMvc.getInstance().loader.start();
			} catch(e:Error) {
				Debug.log("loadHeaderError: " + e);
			}
		}
		
		private function loadDestaque():void {
			try{
				Debug.log ( this + ">>loadDestaque()" );
				avMvc.getInstance().loader.add("internas/destaque.swf");
				avMvc.getInstance().loader.start();
			} catch(e:Error) {
				Debug.log("loadDestaqueError: " + e);
			}
		}
		
		private function loadProdutos():void {
			try{
				Debug.log ( this + ">>loadProdutos()" );
				avMvc.getInstance().loader.add("internas/produtos.swf");
				avMvc.getInstance().loader.start();
			} catch(e:Error) {
				Debug.log("loadProdutosError: " + e);
			}
		}
		
		private function loadCampanha():void {
			try{
				Debug.log ( this + ">>loadCampanha()" );
				avMvc.getInstance().loader.add("internas/campanha.swf");
				avMvc.getInstance().loader.start();
			} catch(e:Error) {
				Debug.log("loadCampanhaError: " + e);
			}
		}
		
		private function loadDesculpas():void {
			try{
				Debug.log ( this + ">>loadDesculpas()" );
				avMvc.getInstance().loader.add("internas/desculpas.swf");
				avMvc.getInstance().loader.start();
			} catch(e:Error) {
				Debug.log("loadDesculpasError: " + e);
			}
		}
		
		private function loadJsonDesculpas():void {
			try{
				Debug.log ( this + ">>loadJsonDesculpas()" );
				avMvc.getInstance().loader.add("internas/desculpas.txt");
				avMvc.getInstance().loader.start();
			} catch(e:Error) {
				Debug.log("loadJsonDesculpasError: " + e);
			}
		}
		
		private function itensComplete(event:avMvcLoaderEvent):void {
			try{
				Debug.log("itensComplete: " + event.item.url);
				if(event.item.url == "internas/config.txt") {
					loadConfig(event);
				} else if(event.item.url == "internas/header.swf") {
					onLoadHeader(event);
				} else if(event.item.url == "internas/destaque.swf") {
					onLoadDestaque(event);
				} else if(event.item.url == "internas/produtos.swf") {
					onLoadProdutos(event);
				} else if(event.item.url == "internas/campanha.swf") {
					onLoadCampanha(event);
				} else if(event.item.url == "internas/desculpas.swf") {
					onLoadDesculpas(event);
				} else if(event.item.url == "internas/peel.swf") {
					onLoadPeel(event);
				} else if(event.item.url == "internas/desculpas.txt") {
					onLoadJsonDesculpas(event);
				}
			} catch(e:Error) {
				Debug.log("itemCompleteError: " + e);
			}
		}
		
		private function onLoadHeader(event:avMvcLoaderEvent):void {
			try {
				Debug.log(this + ">>onLoadHeader()");
				
				var header:MovieClip = MovieClip(event.item.file).header;
				site.mcHeader.addChild(header);
				
				HeaderControl.to(header);
				
				loadDestaque();
				
			} catch(e:Error) {
				Debug.log("itemCompleteError: " + e);
			}
		}
		
		private function onLoadDestaque(event:avMvcLoaderEvent):void {
			try {
				Debug.log(this + ">>onLoadDestaque()");
				
				var destaque:MovieClip = MovieClip(event.item.file).destaque;
				site.mcDestaqueProduto.addChild(destaque);
				
				DestaqueControl.to(destaque);
				
				site.loadingDestaque.gotoAndStop(30);
				
				loadProdutos();
				
			} catch(e:Error) {
				Debug.log("itemCompleteError: " + e);
			}
		}
		
		private function onLoadProdutos(event:avMvcLoaderEvent):void {
			try {
				Debug.log(this + ">>onLoadProdutos()");
				
				var produtos:MovieClip = MovieClip(event.item.file).produtos;
				site.mcProdutos.addChild(produtos);
				
				ProdutosControl.to(produtos);
				
				site.loadingProdutos.gotoAndStop(30);
				
				loadCampanha();
				
			} catch(e:Error) {
				Debug.log("itemCompleteError: " + e);
			}
		}
		
		private function onLoadCampanha(event:avMvcLoaderEvent):void {
			try {
				Debug.log(this + ">>onLoadCampanha()");
				
				var campanha:MovieClip = MovieClip(event.item.file).campanha;
				site.mcCampanha.addChild(campanha);
				
				CampanhaControl.to(campanha);
				
				site.loadingCampanha.gotoAndStop(30);
				
				loadDesculpas();
				
			} catch(e:Error) {
				Debug.log("itemCompleteError: " + e);
			}
		}
		
		private function onLoadDesculpas(event:avMvcLoaderEvent):void {
			try {
				Debug.log(this + ">>onLoadDesculpas()");
				
				var desculpas:MovieClip = MovieClip(event.item.file).desculpas;
				site.mcDesculpas.addChild(desculpas);
				
				site.loadingDesculpas.gotoAndStop(30);
				
				loadJsonDesculpas();
				
			} catch(e:Error) {
				Debug.log("itemCompleteError: " + e);
			}
		}
		
		private function onLoadJsonDesculpas(event:avMvcLoaderEvent):void {
			Debug.log(this + ">>onLoadJsonDesculpas()");
			
			var source:String = event.item.file;
			avMvc.getInstance().config.params.desculpas = JSON.decode(source,false);
			
			var desculpas:MovieClip = site.mcDesculpas.getChildByName("desculpas") as MovieClip;
			
			DesculpasControl.to(desculpas);
			
			loadPeel();
		}
		
		private function onLoadPeel(event:avMvcLoaderEvent):void {
			try {
				Debug.log(this + ">>onLoadPeel()");
				
				var peel:MovieClip = MovieClip(event.item.file).peel;
				site.mcPeel.addChild(peel);
				
				PeelControl.to(peel);
				PeelControl.autoOpen();
				
			} catch(e:Error) {
				Debug.log("onLoadPeelError: " + e);
			}
		}
		
		private function onResize(event:Event = null):void {
			(avMvc.getInstance().loader.loading as Sprite).y = 350;
		}
	}
}
