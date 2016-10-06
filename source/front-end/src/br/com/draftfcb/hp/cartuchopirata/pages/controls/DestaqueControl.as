package br.com.draftfcb.hp.cartuchopirata.pages.controls
{	
	import caurina.transitions.Tweener;
	
	import com.avmvc.avMvc;
	import com.debug.arthropod.Debug;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	public class DestaqueControl
	{
		protected static var _instance:DestaqueControl;
		
		private var produto:MovieClip;
		
		private var frames:Vector.<Number> = new Vector.<Number>();
		private var framesInit:Vector.<Number> = new Vector.<Number>();
		
		private var timeNextDestaque:Number = 10;
		private var posicaoAtual:Number = 0;
		
		private var skipAnimation:Boolean = false;
		private var next:Boolean = true;
		
		public static function to( mc:MovieClip ):void { return getInstance().to(mc); }
		public function to( mc:MovieClip ):void
		{
			produto = mc;
			mc.gotoAndPlay(2);
			setup();
		}
		
		public function setup():void {
			frames = new Vector.<Number>();
			framesInit = new Vector.<Number>();
			
			frames.push(34);
			frames.push(79);
			frames.push(125);
			frames.push(170);
			frames.push(215);
			frames.push(260);
			frames.push(305);
			frames.push(350);
			frames.push(395);
			
			framesInit.push(12);
			framesInit.push(57);
			framesInit.push(103);
			framesInit.push(148);
			framesInit.push(193);
			framesInit.push(238);
			framesInit.push(283);
			framesInit.push(328);
			framesInit.push(373);
			
			produto.addEventListener(Event.ENTER_FRAME, setupDestaqueProduto);
			produto.addEventListener(MouseEvent.CLICK, clickCarrossel);
		}
		
		private function clickCarrossel(e:Event):void {
			var s:String = e.currentTarget.name;
			var sNome:String = e.target.parent.name;
			if (sNome.indexOf("mcProduto")!=-1) {
				var sTagXML:String = sNome.replace("mcProduto","");
				var sURL:String = avMvc.getInstance().config.params.produtos[sTagXML].url;
				navigateToURL(new URLRequest(sURL), "_blank");
			}
		}
		
		private function setupDestaqueProduto(e:Event):void {
			if(MovieClip(e.currentTarget).currentFrame == frames[0]) {
				produto.stop();
				produto.removeEventListener(Event.ENTER_FRAME, setupDestaqueProduto);
				produto.btNext.addEventListener(MouseEvent.CLICK, nextDestaqueProduto);
				produto.btPrevious.addEventListener(MouseEvent.CLICK, previousDestaqueProduto);
				produto.mcProdutoVentilador.flvVentilator.addEventListener("complete", loopVideo);
				
				Tweener.addTween(produto.mcProdutoVentilador, {time:timeNextDestaque, onComplete:loopDestaqueProduto});
			}
		}
		
		private function loopVideo(e:Event):void {
			produto.mcProdutoVentilador.flvVentilator.play();
		};
		
		private function loopDestaqueProduto():void {
			Debug.log("loopDestaqueProduto");
			if(!skipAnimation) {
				if(next) {
					nextDestaqueProduto();	
				} else {
					previousDestaqueProduto();
				}
			} else {
				skipAnimation = false;
			}
			
			Tweener.addTween(produto.mcProdutoVentilador, {time:timeNextDestaque, onComplete:loopDestaqueProduto});
		}
		
		private function nextDestaqueProduto(e:Event = null):void {
			if(e != null) {
				skipAnimation = true;
			}
			posicaoAtual++;
			if(posicaoAtual >= frames.length ) {
				posicaoAtual--;
				next = false;
			} else {
				next = true;
				var frame:int = frames[posicaoAtual];
				Tweener.addTween(produto,{ time:3.5, _frame:frame });
			}
			
			if (posicaoAtual>0) {
				produto.mcProdutoVentilador.flvVentilator.stop();
			}
		}
		
		private function previousDestaqueProduto(e:Event = null):void {
			if(e != null) {
				skipAnimation = true;
			}
			
			posicaoAtual--;
			
			var x:int = produto.currentFrame;
			if(posicaoAtual < 0) {
				posicaoAtual++;
				next = true;
			} else {
				var frame:int = frames[posicaoAtual];
				Tweener.addTween(produto,{ time:3.5, _frame:frame });
			}
			
			if (posicaoAtual==0) {
				produto.mcProdutoVentilador.flvVentilator.play();
				produto.mcProdutoVentilador.flvVentilator.volume=1;
			}
		} 
		
		private function previousProduto():void {
			produto.alpha = 1;
			produto.gotoAndPlay(framesInit[posicaoAtual]);
		}
		
		public static function goTo(posicao:Number):void { return getInstance().goTo(posicao); }
		public function goTo(posicao:Number):void {
			skipAnimation = true;
			posicaoAtual = posicao;
			Tweener.addTween(produto,{ time:1, alpha:0, onComplete:previousProduto });
		}
		
		protected static function getInstance():DestaqueControl {
			if (_instance == null) { _instance= new DestaqueControl(); }
			return _instance;
		}
	}
}