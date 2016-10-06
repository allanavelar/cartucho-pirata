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

	public class DesculpasControl
	{
		protected static var _instance:DesculpasControl;
		
		private const MAX_PEQ:uint = 94;
		private const MAX_MED:uint = 132;
		private const TEMPO_ANIMACAO_INIT:Number = 0.5;
		private const TEMPO_ANIMACAO_FINAL:Number = 1.3;
		
		private var desculpas:MovieClip;
		private var jsonDesculpas:Array;
		
		private var frameSetup:Number = 73;
		private var posicaoAtual:Number = 0;
		private var yInitAnimacao:Number = -119.85;
		private var yFinalAnimacao:Number = 100.65;
		private var yBalao:Number = -49;
		
		private var flMovieComplete:Boolean = false;
		private var flShowDesculpas:Boolean = false;
		
		private var txtDesculpas:DesculpasTxt;
		
		public static function to( mc:MovieClip ):void { return getInstance().to(mc); }
		public function to( mc:MovieClip ):void
		{
			desculpas = mc;
			mc.gotoAndPlay(2);
			setup();
		}
		
		public function setup():void {
			jsonDesculpas = avMvc.getInstance().config.params.desculpas;
			jsonDesculpas.sort(function ():Number {
				return Math.round(Math.random() * Math.random() * 100);
			});
			
			jsonDesculpas = shuffleArray(jsonDesculpas);
			
			desculpas.txtTituloChefe.visible = desculpas.txtTituloMae.visible = desculpas.txtTituloNamorada.visible = false;
			desculpas.addEventListener(Event.ENTER_FRAME, setupDesculpas);
		}
		
		private function setupDesculpas(e:Event):void {;
			if(MovieClip(e.currentTarget).currentFrame == frameSetup) {
				flMovieComplete = true;
				desculpas.removeEventListener(Event.ENTER_FRAME, setupDesculpas);
				
				if(!flShowDesculpas) {
					flShowDesculpas = true;
					showDesculpa();
				}
				desculpas.btNext.addEventListener(MouseEvent.CLICK, next);
				desculpas.btPrevious.addEventListener(MouseEvent.CLICK, previous);
			} else if(MovieClip(e.currentTarget).currentFrame == 63) {
				
			}
		}
		
		private function showDesculpa(next:Boolean = true):void {
			Debug.log(this + "showDesculpa: " + next);
			removeDesculpa(next);
		}
		
		private function posRemoveDesculpa(next:Boolean):void {
			Debug.log(this + "posRemoveDesculpa: " + next);
			var msg:String = jsonDesculpas[posicaoAtual].mensagem;
			
			txtDesculpas = new DesculpasTxt();
			
			if(msg.length <= MAX_PEQ) {
				txtDesculpas.txtMsgPeq.text = jsonDesculpas[posicaoAtual].mensagem;
				txtDesculpas.txtMsgMed.visible = false;
				txtDesculpas.txtMsgGrd.visible = false;
			} else if(msg.length <= MAX_MED) {
				txtDesculpas.txtMsgMed.text = jsonDesculpas[posicaoAtual].mensagem;
				txtDesculpas.txtMsgPeq.visible = false;
				txtDesculpas.txtMsgGrd.visible = false;
			} else {
				txtDesculpas.txtMsgGrd.text = jsonDesculpas[posicaoAtual].mensagem;
				txtDesculpas.txtMsgPeq.visible = false;
				txtDesculpas.txtMsgMed.visible = false;
			}
			
			if(jsonDesculpas[posicaoAtual].titulo == "para o seu chefe") {
				desculpas.txtTituloChefe.gotoAndPlay(0);
				desculpas.txtTituloChefe.visible = true;
				desculpas.txtTituloMae.visible = false;
				desculpas.txtTituloNamorada.visible = false;
			} else if(jsonDesculpas[posicaoAtual].titulo == "para a sua mãe") {
				desculpas.txtTituloChefe.visible = false;
				desculpas.txtTituloMae.gotoAndPlay(0);
				desculpas.txtTituloMae.visible = true;
				desculpas.txtTituloNamorada.visible = false;
			} else if(jsonDesculpas[posicaoAtual].titulo == "para a sua namorada") {
				desculpas.txtTituloChefe.visible = false;
				desculpas.txtTituloMae.visible = false;
				desculpas.txtTituloNamorada.gotoAndPlay(0);
				desculpas.txtTituloNamorada.visible = true;
			}
			txtDesculpas.mouseEnabled = false;
			txtDesculpas.mouseChildren = false;
			
			txtDesculpas.x = -91.3;
			
			var yPos:Number = -(txtDesculpas.height/2);
			
			if (next) {
				txtDesculpas.y = yInitAnimacao;
				Tweener.addTween(txtDesculpas, {time:TEMPO_ANIMACAO_INIT, y:yPos+15, onComplete:completeAnimacao});
			} else {
				txtDesculpas.y = yFinalAnimacao; 
				Tweener.addTween(txtDesculpas, {time:TEMPO_ANIMACAO_INIT, y:yPos-15, onComplete:completeAnimacao});
			}
			
			desculpas.mcMsgDesculpas.addChild(txtDesculpas);
			
			/*trace("peq ----" + txtDesculpas.txtMsgPeq.text)
			trace("med ----" + txtDesculpas.txtMsgMed.text)
			trace("Grd ----" + txtDesculpas.txtMsgGrd.text)*/
		}
		
		private function completeAnimacao():void {
			Tweener.addTween(txtDesculpas, {time:TEMPO_ANIMACAO_FINAL, y:-(txtDesculpas.height/2)+3});
		}
		
		private function removeDesculpa(next:Boolean):void {
			Debug.log(this + "removeDesculpa: " + next);
			Debug.log(this + "txtDesculpas: " + txtDesculpas);
			if(txtDesculpas != null && desculpas.mcMsgDesculpas.contains(txtDesculpas)) {
				if(next) {
					Tweener.addTween(txtDesculpas, {time:TEMPO_ANIMACAO_INIT, y:yFinalAnimacao, onComplete:completeAnimacaoRemove, onCompleteParams:[next]});
				} else {
					Tweener.addTween(txtDesculpas, {time:TEMPO_ANIMACAO_INIT, y:yInitAnimacao - txtDesculpas.height/2, onComplete:completeAnimacaoRemove, onCompleteParams:[next]});
				}
			} else {
				posRemoveDesculpa(true);
			}
		}
		
		private function completeAnimacaoRemove(next:Boolean):void {
			desculpas.mcMsgDesculpas.removeChild(txtDesculpas);
			posRemoveDesculpa(next);
		}
		
		private function next(e:Event):void {
			Debug.log(this + "pos:" + posicaoAtual + ">>next");
			posicaoAtual++;
			if(posicaoAtual >= jsonDesculpas.length ) {
				posicaoAtual--;
			} else {
				showDesculpa();
			}
		}
		
		private function previous(e:Event):void {
			Debug.log(this + "pos:" + posicaoAtual + ">>previous");
			posicaoAtual--;
			if(posicaoAtual < 0) {
				posicaoAtual++;
			} else {
				showDesculpa(false);
			}
		}
		
		public function shuffleArray(value:Array):Array {
			var len:int = value.length;
			var temp:*;
			var i:int = len;
			while (i--) {
				var rand:int = Math.floor(Math.random() * len);
				temp = value[i];
				value[i] = value[rand];
				value[rand] = temp;
			}
			return value;
		}
		
		protected static function getInstance():DesculpasControl {
			if (_instance == null) { _instance= new DesculpasControl(); }
			return _instance;
		}
	}
}