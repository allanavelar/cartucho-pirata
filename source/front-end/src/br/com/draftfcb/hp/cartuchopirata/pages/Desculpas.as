package br.com.draftfcb.hp.cartuchopirata.pages {
	
	import caurina.transitions.Tweener;
	
	import com.avmvc.events.PageEvent;
	import com.avmvc.interfaces.IPage;
	import com.avmvc.view.Page;
	
	import flash.external.ExternalInterface;

	/**
	 * <b>Author:</b> Allan Avelar<br />
	 */
	
	public class Desculpas extends Page implements IPage {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function Desculpas() {
			alpha = 0;
			visible = false;
			addEventListener(PageEvent.INITIALIZED, initialized, false, 0, true);
			addEventListener(PageEvent.CONTENT_PARSED, contentParsed, false, 0, true);
			addEventListener(PageEvent.CONTENT_COMPLETE, contentComplete, false, 0, true);
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		private function initialized(e:PageEvent = null):void {
			removeEventListener(PageEvent.INITIALIZED, initialized, false);
			// initialization complete, build page elements here
		}
		
		private function contentParsed(e:PageEvent):void {
			removeEventListener(PageEvent.CONTENT_PARSED, contentParsed, false);
			// assets parsed and ready (except the assets that need to be loaded), retrieve the assets using: getAssetByID(myAssetID)
		}
		
		private function contentComplete(e:PageEvent):void {
			removeEventListener(PageEvent.CONTENT_COMPLETE, contentComplete, false);
			// assets fully parsed and loaded, retrieve the assets using: getAssetByID(myAssetID)
		}
		
		private function dispose():void {
			// remove and destroy everything in the page
			removeEventListener(PageEvent.INITIALIZED, initialized, false);
			removeEventListener(PageEvent.CONTENT_PARSED, contentParsed, false);
			removeEventListener(PageEvent.CONTENT_COMPLETE, contentComplete, false);
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		override public function transitionIn():void {
			// start of the transition to show the page, then call super.transitionIn
			Tweener.addTween(this, {time:0, _autoAlpha:1, onComplete:super.transitionIn});
		}

		override public function transitionInComplete():void {
			// end of the transition to show the page, then call super.transitionInComplete
			super.transitionInComplete();
			
			try {
				ExternalInterface.call("scrollToDesculpas");
			} catch(e:Error) {
				
			}
		}
		
		override public function transitionOut():void {
			// start of the transition to hide the page, then call super.transitionOut
			Tweener.addTween(this, {time:0, _autoAlpha:0, onComplete:super.transitionOut});
		}
		
		override public function transitionOutComplete():void {
			// end of the transition to hide the page, then call super.transitionOutComplete
			dispose();
			super.transitionOutComplete();
		}
		
	}
}
