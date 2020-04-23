import pilot.wings.Positioned.PositionedSide;
import pilot.wings.*;
import pilot.wings.form.TextControl;
import pilot.Component;

class Test {

  public static function main() {
    var body = PortalProvider.node({
      children: [
        ModalTest.node({}),
        PopoverTest.node({})
      ]
    });
    #if (js && !nodejs)
      pilot.platform.dom.Dom.mount(
        js.Browser.document.getElementById('root'),
        body
      );
    #else
      var doc = pilot.platform.server.Server.renderDocument(
        Pilot.html(<>
          <title>Test</title>
          <style>
            {pilot.StyleManager.toString()}
          </style>
        </>),
        body
      );
      Sys.print(doc);
    #end
  }

}

class PopoverTest extends Component {
  
  @:attribute(state) var side:PositionedSide = Bottom;

  override function render() return html(
    <div class={css('
      display: flex;
      justify-content: center;
    ')}>
      <button onClick={_ -> side = Top}>Top</button>
      <button onClick={_ -> side = Bottom}>Bottom</button>
      <button onClick={_ -> side = Left}>Left</button>
      <button onClick={_ -> side = Right}>Right</button>
      <Popover
        containerStyle={css('
          background: #ccc;
          width: 200px;
          height: 50px;
        ')}
        popoverStyle={css('
          background: #fff;
          border: 1px solid #000;
          padding: 10px;
          width: 100%;
          width: 100px;
          p {
            margin: 0;
          }
        ')}
        isOpen={false}
        label={ (options) -> <>
          { if (options.isOpen) 'Close' else 'Open' }
        </> }
        side={side}
      >
        <p>Hello world</p>
      </Popover>
    </div>
  );

}

class ModalTest extends Component {

  @:attribute var title:String = 'Example';
  @:attribute(state) var showModal:Bool = false;
  @:attribute(state) var content:String = 'Hello world';

  override function render() return html(<>
    <button onClick={_ -> showModal = true}>Show Modal</button>
    { 
      if (showModal)
        <Modal 
          requestClose={() -> {
            showModal = false;
            trace('hiding modal');
          }}
          overlayStyle={css('
            background: rgba(0, 0, 0, 0.5);
          ')}
          modalStyle={css('
            background: #fff;
            padding: 1rem;
            width: 100%;
            max-width: 900px;          
          ')}
          position={PositionCentered}
        >
          <ModalHeader 
            content={ <h2>{title}</h2> } 
            requestClose={() -> showModal = false} 
          />
          {content}
          <ul>
            <li>
              <Form id="test" action="#" onSubmit={e -> e.preventDefault()}>
                <TextControl
                  id="set-content"
                  label="Set Content" 
                  value={content} 
                  onCommit={value -> content = value} 
                />
              </Form>
            </li>
          </ul>
        </Modal>
      else
        null
    }
  </>);

}
