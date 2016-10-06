package br.com.draftfcb.hp.cartuchopirata.pages.controls
{	
	import br.com.draftfcb.utils.Facebook;
	import br.com.draftfcb.utils.Orkut;
	import br.com.draftfcb.utils.Twitter;
	
	import caurina.transitions.Tweener;
	
	import com.avmvc.avMvc;
	import com.avmvc.events.PageEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;

	public class HeaderControl
	{
		protected static var _instance	:HeaderControl;
		
		private var header:MovieClip;
		
		public static function to( mc:MovieClip ):void { return getInstance().to(mc); }
		public function to( mc:MovieClip ):void
		{
			header = mc; mc.gotoAndPlay(2);
			
			header.mcMenu.btProdutos.buttonMode = true;
			header.mcMenu.btProdutos.btProdutos.addEventListener(MouseEvent.CLICK, clickProdutos);
			header.mcMenu.btProdutos.btProdutos.addEventListener(MouseEvent.MOUSE_OUT, produtosMouseOut);
			header.mcMenu.btProdutos.btProdutos.addEventListener(MouseEvent.MOUSE_OVER, onMcOver);
			
			header.mcMenu.btCampanha.buttonMode = true;
			header.mcMenu.btCampanha.btCampanha.addEventListener(MouseEvent.CLICK, clickCampanhas);
			header.mcMenu.btCampanha.btCampanha.addEventListener(MouseEvent.MOUSE_OUT, campanhasMouseOut);
			header.mcMenu.btCampanha.btCampanha.addEventListener(MouseEvent.MOUSE_OVER, onMcOver);
			
			header.mcMenu.btDesculpas.buttonMode = true;
			header.mcMenu.btDesculpas.btDesculpas.addEventListener(MouseEvent.CLICK, clickDesculpas);
			header.mcMenu.btDesculpas.btDesculpas.addEventListener(MouseEvent.MOUSE_OUT, desculpasMouseOut);
			header.mcMenu.btDesculpas.btDesculpas.addEventListener(MouseEvent.MOUSE_OVER, onMcOver);
			
			header.mcRedesSociais.btTwitter.buttonMode = true;
			header.mcRedesSociais.btFacebook.buttonMode = true;
			header.mcRedesSociais.btOrkut.buttonMode = true;
			
			header.mcRedesSociais.btTwitter.mouseChildren = false;
			header.mcRedesSociais.btFacebook.mouseChildren = false;
			header.mcRedesSociais.btOrkut.mouseChildren = false;
			
			header.mcRedesSociais.btTwitter.addEventListener(MouseEvent.CLICK, clickTwitter);
			header.mcRedesSociais.btTwitter.addEventListener(MouseEvent.MOUSE_OVER, onRSOver);
			header.mcRedesSociais.btTwitter.addEventListener(MouseEvent.MOUSE_OUT, onRSOut);
			
			header.mcRedesSociais.btFacebook.addEventListener(MouseEvent.CLICK, clickFacebook);
			header.mcRedesSociais.btFacebook.addEventListener(MouseEvent.MOUSE_OVER, onRSOver);
			header.mcRedesSociais.btFacebook.addEventListener(MouseEvent.MOUSE_OUT, onRSOut);
			
			header.mcRedesSociais.btOrkut.addEventListener(MouseEvent.CLICK, clickOrkut);
			header.mcRedesSociais.btOrkut.addEventListener(MouseEvent.MOUSE_OVER, onRSOver);
			header.mcRedesSociais.btOrkut.addEventListener(MouseEvent.MOUSE_OUT, onRSOut);
		}
		
		private function onMcOver(e:Event):void {
			e.currentTarget.gotoAndPlay(2);
		}
		private function onRSOver(e:Event):void {
			e.currentTarget.gotoAndStop(2);
		}
		private function onRSOut(e:Event):void {
			e.currentTarget.gotoAndStop(1);
		}
		
		private function desculpasMouseOut(e:Event):void {
			header.mcMenu.btDesculpas.btDesculpas.gotoAndPlay(21);
		}
		private function campanhasMouseOut(e:Event):void {
			header.mcMenu.btCampanha.btCampanha.gotoAndPlay(12);
		}
		private function produtosMouseOut(e:Event):void {
			header.mcMenu.btProdutos.btProdutos.gotoAndPlay(11);
		}
		
		private function clickProdutos(e:Event):void {
			new PageEvent(PageEvent.SHOW, "Produtos").dispatch();
		}
		private function clickCampanhas(e:Event):void {
			new PageEvent(PageEvent.SHOW, "Campanha").dispatch();
		}
		private function clickDesculpas(e:Event):void {
			new PageEvent(PageEvent.SHOW, "Desculpas").dispatch();
		}
		
		private function clickTwitter(e:Event):void {
			Twitter.share(avMvc.getInstance().config.params.twitter.status);
		}
		
		private function clickFacebook(e:Event):void {
			Facebook.share(avMvc.getInstance().config.params.facebook.url);
		}
		
		private function clickOrkut(e:Event):void {
			Orkut.share(
				avMvc.getInstance().config.params.orkut.titulo,
				avMvc.getInstance().config.params.orkut.mensagem,
				avMvc.getInstance().config.params.orkut.link
			);
		}
		
		protected static function getInstance():HeaderControl {
			if (_instance == null) { _instance= new HeaderControl(); }
			return _instance;
		}
	}
}