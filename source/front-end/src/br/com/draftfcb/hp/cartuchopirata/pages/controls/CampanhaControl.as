package br.com.draftfcb.hp.cartuchopirata.pages.controls
{	
	import caurina.transitions.Tweener;
	
	import com.avmvc.avMvc;
	import com.avmvc.events.PageEvent;
	import com.debug.arthropod.Debug;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class CampanhaControl
	{
		protected static var _instance:CampanhaControl;
		
		private var campanha:MovieClip;
		private var frameSetup:Number = 62;
		
		public static function to( mc:MovieClip ):void { return getInstance().to(mc); }
		public function to( mc:MovieClip ):void
		{
			campanha = mc;
			mc.gotoAndPlay(2);
			setup();
		}
		
		public function setup():void {
			campanha.addEventListener(Event.ENTER_FRAME, setupCampanha);
		}
		
		private function setupCampanha(e:Event):void {
			
			if (campanha.mcTv!=null) {
				campanha.mcTv.hit.addEventListener(MouseEvent.CLICK, onClickTv);
			}
			
			if (campanha.btNext!=null) {
				campanha.btNext.addEventListener(MouseEvent.CLICK, onClickNext);
			}
			
			if (campanha.btPrevious!=null) {
				campanha.btPrevious.addEventListener(MouseEvent.CLICK, onClickBack);
			}
			
			if(MovieClip(e.currentTarget).currentFrame == frameSetup) {
				campanha.stop(); campanha.removeEventListener(Event.ENTER_FRAME, setupCampanha);
			}
		}
		
		private function onClickNext(e:MouseEvent):void {
			if (campanha.mcTv.imagem.currentFrame == campanha.mcTv.imagem.totalFrames) {
				campanha.mcTv.imagem.gotoAndStop(1);
			} else {
				campanha.mcTv.imagem.gotoAndStop(campanha.mcTv.imagem.currentFrame + 1);
			}
			avMvc.getInstance().config.params.campanha.atual = campanha.mcTv.imagem.currentFrame;
		}
		
		private function onClickBack(e:MouseEvent):void {
			if (campanha.mcTv.imagem.currentFrame == 1) {
				campanha.mcTv.imagem.gotoAndStop(campanha.mcTv.imagem.totalFrames);
			} else {
				campanha.mcTv.imagem.gotoAndStop(campanha.mcTv.imagem.currentFrame - 1);
			}
			avMvc.getInstance().config.params.campanha.atual = campanha.mcTv.imagem.currentFrame;
		}
		
		private function onClickTv(e:Event):void {
			avMvc.getInstance().config.params.campanha.atual = campanha.mcTv.imagem.currentFrame;
			new PageEvent(PageEvent.SHOW, "VideoCampanha").dispatch();
		}
		
		protected static function getInstance():CampanhaControl {
			if (_instance == null) { _instance= new CampanhaControl(); }
			return _instance;
		}
	}
}