package br.com.draftfcb.hp.cartuchopirata.loading.basic {
	
	import caurina.transitions.Tweener;
	import com.avmvc.loader.ILoading;
	import com.avmvc.loader.avMvcLoaderEvent;
	import com.avmvc.view.avMvcText;
	import flash.display.Sprite;

	/**
	 * <b>Author:</b> Allan Avelar<br />
	 * <b>Site:</b> www.allanavelar.com.br<br />
	 * <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 */
	
	public class BasicLoading extends Sprite implements ILoading {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		public var info:avMvcText;
		public var lineItem:Sprite;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function BasicLoading() {
			init();
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		protected function init():void {
			//draw();
		}
		
		protected function draw():void {
			graphics.beginFill(0x000000, .7);
			graphics.drawRect(0, 0, 180, 40);
			info = new avMvcText("", "bodyWhite");
			info.x = 10;
			info.y = 7;
			addChild(info);
			lineItem = new Sprite();
			lineItem.x = 10;
			lineItem.y = 28;
			lineItem.graphics.beginFill(0xFFFFFF);
			lineItem.graphics.drawRect(0, 0, 160, 1);
			lineItem.width = 0;
			addChild(lineItem);
			// set to true to see an item progression
			lineItem.visible = true;
		}
		
		//
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function itemStart(e:avMvcLoaderEvent):void {
			
		}
		
		public function itemProgress(e:avMvcLoaderEvent):void {
			//lineItem.width = 160 * e.percentItem / 100;
		}
		
		public function itemComplete(e:avMvcLoaderEvent):void {
			
		}
		
		public function queueStart():void {
			//Tweener.addTween(this, {time: .7, _autoAlpha:1});
		}

		public function queueProgress(e:avMvcLoaderEvent):void {
			
		}
		
		public function queueComplete():void {
			//Tweener.addTween(this, {time: .7, _autoAlpha:0});
		}
		
		public function error(e:avMvcLoaderEvent):void {
			
		}
		
	}
	
}
