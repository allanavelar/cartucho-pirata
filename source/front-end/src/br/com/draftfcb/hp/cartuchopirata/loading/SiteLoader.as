package br.com.draftfcb.hp.cartuchopirata.loading
{
	import caurina.transitions.Tweener;
	
	import com.soundstep.ui.BaseUI;
	import com.soundstep.ui.ElementUI;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	/**
	 * <b>Author:</b> Allan Avelar<br />
	 * <b>Site:</b> www.allanavelar.com.br<br />
	 * <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 */
	public class SiteLoader extends Sprite
	{
		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		private var _background:Sprite;
		private var _loading:Sprite;
		
		private var _loader:Loader;
		private var _file:String;
		
		//------------------------------------
		// public properties
		//------------------------------------
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		/** Creates a SiteLoader instance.
		 * @param file Name of the swf file to load.
		 * @param root Movieclip container of display.
		 */
		public function SiteLoader(file:String, root:Sprite, nameSprite:String = "Main", autoStart:Boolean = true) {
			
			name = nameSprite;
			visible = false;
			_file = file;
			
			_background = new bgColor();
			
			var baseUI:BaseUI = new BaseUI(this);
			var element:ElementUI = baseUI.add(_background);
			element.ratio = "ratio_out";
			element.alignX = "center";
			element.alignY = "center";
			
			addChild(_background);
			
			_loading = new LoadingSite();
			addChild(_loading);
			
			if (autoStart) start();
		}
		
		//
		// PRIVATE
		//________________________________________________________________________________________________
		
		private function startHandler(e:Event):void {
			update();
		}
		
		private function progressHandler(e:ProgressEvent):void {
			var percent:Number = Math.round(e.bytesLoaded * 100 / e.bytesTotal);
			_loading["porcent"].texto.text = percent;
			update();
		}
		
		private function initHandler(e:Event):void {
			update();
			dispose();
		}
		
		private function errorHandler(e:IOErrorEvent):void {
			trace("Error loading " + _loader.content);
		}
		
		private function completeHandler(e:Event):void {
			removeChild(_background);
			removeChild(_loading);
			dispose();
		}
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		/**
		 * Removes TextField and listeners.
		 */
		public function dispose():void {
			_loader.contentLoaderInfo.removeEventListener(Event.OPEN, startHandler, false);
			_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressHandler, false);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler, false, 0, true);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler, false);
			_loader.contentLoaderInfo.removeEventListener(Event.INIT, initHandler, false);			
		}
		
		/**
		 * Starts the loading (in case autoStart has been set to false in the constructor), a LoaderContext instance can be used.
		 * @param loaderContext A LoaderContext instance.
		 */
		public function start(loaderContext:LoaderContext = null):void {
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.OPEN, startHandler, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(Event.INIT, initHandler, false, 0, true);
			_loader.load(new URLRequest(_file), loaderContext);
			addChild(_loader);
		}
		
		/**
		 * Center the Movieclips instance in the middle of the screen.
		 */
		private function update():void {
			if (stage != null) {
				visible = (stage.stageWidth != 0 && stage.stageHeight != 0);
				_loading.x = Math.round((stage.stageWidth * .5));
				_loading.y = 350;
			}
		}
		
		/**
		 * Get the Loader instance used to process the loading.
		 * @return A Loader instance.
		 */
		public function get loader():Loader {
			return _loader;
		}
		
		/**
		 * Get the url of the file.
		 * @return A String.
		 */
		public function get file():String {
			return _file;
		}
		
		protected const Author	:String = 'Allan Avelar';
		protected const Email	:String = 'contato@allanavelar.com.br';
	}
}