package br.com.draftfcb.hp.cartuchopirata.pages.controls
{	
	import caurina.transitions.Tweener;
	
	import com.avmvc.avMvc;
	import com.debug.arthropod.Debug;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	public class ProdutosControl
	{
		protected static var _instance	:ProdutosControl;
		
		private var produtos:MovieClip;
		
		private var frameSetup:Number = 70;
		
		public static function to( mc:MovieClip ):void { return getInstance().to(mc); }
		public function to( mc:MovieClip ):void
		{
			produtos = mc;
			mc.gotoAndPlay(2);
			setup();
		}
		
		public function setup():void {
			produtos.addEventListener(Event.ENTER_FRAME, setupProdutos);
		}
		
		private function setupProdutos(e:Event):void {
			if(MovieClip(e.currentTarget).currentFrame == frameSetup) {
				produtos.removeEventListener(Event.ENTER_FRAME, setupProdutos);
				
				produtos.mcVentilador.btSaibaMaisCompreJa.btSaibaMais.addEventListener(MouseEvent.CLICK, clickSaibaMaisVentilador);
				produtos.mcVentilador.btSaibaMaisCompreJa.btCompreJa.addEventListener(MouseEvent.CLICK, clickCompreJaVentilador);
				
				produtos.mcOculos.btSaibaMaisCompreJa.btSaibaMais.addEventListener(MouseEvent.CLICK, clickSaibaMaisOculos);
				produtos.mcOculos.btSaibaMaisCompreJa.btCompreJa.addEventListener(MouseEvent.CLICK, clickCompreJaOculos);
				
				produtos.mcPersonalRetratista.btSaibaMaisCompreJa.btSaibaMais.addEventListener(MouseEvent.CLICK, clickSaibaMaisPersonalRetratista);
				produtos.mcPersonalRetratista.btSaibaMaisCompreJa.btCompreJa.addEventListener(MouseEvent.CLICK, clickCompreJaPersonalRetratista);
				
				produtos.mcGravador.btSaibaMaisCompreJa.btSaibaMais.addEventListener(MouseEvent.CLICK, clickSaibaMaisGravador);
				produtos.mcGravador.btSaibaMaisCompreJa.btCompreJa.addEventListener(MouseEvent.CLICK, clickCompreJaGravador);
				
				produtos.mcDesentupeitor.btSaibaMaisCompreJa.btSaibaMais.addEventListener(MouseEvent.CLICK, clickSaibaMaisDesentupeitor);
				produtos.mcDesentupeitor.btSaibaMaisCompreJa.btCompreJa.addEventListener(MouseEvent.CLICK, clickCompreJaDesentupeitor);
				
				produtos.mcAlbumFotos.btSaibaMaisCompreJa.btSaibaMais.addEventListener(MouseEvent.CLICK, clickSaibaMaisAlbumFotos);
				produtos.mcAlbumFotos.btSaibaMaisCompreJa.btCompreJa.addEventListener(MouseEvent.CLICK, clickCompreJaAlbumFotos);
				
				produtos.mcPincas.btSaibaMaisCompreJa.btSaibaMais.addEventListener(MouseEvent.CLICK, clickSaibaMaisPincas);
				produtos.mcPincas.btSaibaMaisCompreJa.btCompreJa.addEventListener(MouseEvent.CLICK, clickCompreJaPincas);
				
				produtos.mcTelaEmBranco.btSaibaMaisCompreJa.btSaibaMais.addEventListener(MouseEvent.CLICK, clickSaibaMaisTelaEmBranco);
				produtos.mcTelaEmBranco.btSaibaMaisCompreJa.btCompreJa.addEventListener(MouseEvent.CLICK, clickCompreJaTelaEmBranco);
				
				produtos.mcMucamas.btSaibaMaisCompreJa.btSaibaMais.addEventListener(MouseEvent.CLICK, clickSaibaMaisMucamas);
				produtos.mcMucamas.btSaibaMaisCompreJa.btCompreJa.addEventListener(MouseEvent.CLICK, clickCompreJaMucamas);
			}
		}
		
		private function clickSaibaMaisVentilador(e:Event):void {
			showDestaque(avMvc.getInstance().config.params.produtos.Ventilador.position);
		}		
		private function clickCompreJaVentilador(e:Event):void {
			openBrowser(avMvc.getInstance().config.params.produtos.Ventilador.url);
		}
		
		private function clickSaibaMaisOculos(e:Event):void {
			showDestaque(avMvc.getInstance().config.params.produtos.Oculos.position);
		}		
		private function clickCompreJaOculos(e:Event):void {
			openBrowser(avMvc.getInstance().config.params.produtos.Oculos.url);
		}
		
		private function clickSaibaMaisPersonalRetratista(e:Event):void {
			showDestaque(avMvc.getInstance().config.params.produtos.Personal.position);
		}		
		private function clickCompreJaPersonalRetratista(e:Event):void {
			openBrowser(avMvc.getInstance().config.params.produtos.Personal.url);
		}
		
		private function clickSaibaMaisGravador(e:Event):void {
			showDestaque(avMvc.getInstance().config.params.produtos.Gravador.position);
		}		
		private function clickCompreJaGravador(e:Event):void {
			openBrowser(avMvc.getInstance().config.params.produtos.Gravador.url);
		}
		
		private function clickSaibaMaisDesentupeitor(e:Event):void {
			showDestaque(avMvc.getInstance().config.params.produtos.Desentupeitor.position);
		}		
		private function clickCompreJaDesentupeitor(e:Event):void {
			openBrowser(avMvc.getInstance().config.params.produtos.Desentupeitor.url);
		}
		
		private function clickSaibaMaisAlbumFotos(e:Event):void {
			showDestaque(avMvc.getInstance().config.params.produtos.AlbumFotos.position);
		}		
		private function clickCompreJaAlbumFotos(e:Event):void {
			openBrowser(avMvc.getInstance().config.params.produtos.AlbumFotos.url);
		}
		
		private function clickSaibaMaisPincas(e:Event):void {
			showDestaque(avMvc.getInstance().config.params.produtos.Pincas.position);
		}		
		private function clickCompreJaPincas(e:Event):void {
			openBrowser(avMvc.getInstance().config.params.produtos.Pincas.url);
		}
		
		private function clickSaibaMaisTelaEmBranco(e:Event):void {
			showDestaque(avMvc.getInstance().config.params.produtos.TelaBranco.position);
		}		
		private function clickCompreJaTelaEmBranco(e:Event):void {
			openBrowser(avMvc.getInstance().config.params.produtos.TelaBranco.url);
		}
		
		private function clickSaibaMaisMucamas(e:Event):void {
			showDestaque(avMvc.getInstance().config.params.produtos.Mucanas.position);
		}		
		private function clickCompreJaMucamas(e:Event):void {
			openBrowser(avMvc.getInstance().config.params.produtos.Mucanas.url);
		}
		
		private function openBrowser(url:String):void {
			try {
				ExternalInterface.call("openBrowser", url);
			} catch(e:Error) {
				
			}
		}
		
		private function showDestaque(pos:String):void {
			try {
				ExternalInterface.call("scrollToTop");
				DestaqueControl.goTo(Number(pos));
			} catch(e:Error) {
				
			}
		}
		
		protected static function getInstance():ProdutosControl {
			if (_instance == null) { _instance= new ProdutosControl(); }
			return _instance;
		}
	}
}