import pilot.wings.Positioned.PositionedSide;
import pilot.wings.*;
import pilot.wings.form.TextControl;
import pilot.Component;

class Test {

  public static function main() {
    Pilot.mount(
      Pilot.dom.getElementById('root'),
      Pilot.html(<>
        <PortalProvider>
          <ModalTest />
          <PopoverTest />
        </PortalProvider>
      </>)
    );
  }

}

class PopoverTest extends Component {
  
  @:attribute(mutable = true) var side:PositionedSide = Bottom;

  override function render() return html(
    <div class@style={
      display: flex;
      justify-content: center;
    }>
      <button onClick={_ -> side = Top}>Top</button>
      <button onClick={_ -> side = Bottom}>Bottom</button>
      <button onClick={_ -> side = Left}>Left</button>
      <button onClick={_ -> side = Right}>Right</button>
      <Popover
        containerStyle@style={
          background: #ccc;
          width: 200px;
          height: 50px;
        }
        popoverStyle@style={
          background: #fff;
          border: 1px solid #000;
          padding: 10px;
          width: 100%;
          width: 100px;
          p {
            margin: 0;
          }
        }
        isOpen={false}
        label={(options) -> Pilot.html(<if {options.isOpen}>
          Close
        <else>
          Open
        </if>)}
        side={side}
      >
        <p>Hello world</p>
      </Popover>
    </div>
  );

}

class ModalTest extends Component {

  @:attribute var title:String = 'Example';
  @:attribute(mutable = true) var showModal:Bool = false;
  @:attribute(mutable = true) var content:String = 'Hello world';

  override function render() return html(<>
    <button onClick={_ -> showModal = true}>Show Modal</button>
    <if {showModal}>
      <Modal 
        requestClose={() -> {
          trace('hiding modal');
          showModal = false;
        }}
        overlayStyle@style={
          background: rgba(0, 0, 0, 0.5);
        }
        modalStyle@style={
          background: #fff;
          padding: 1rem;
          width: 100%;
          max-width: 900px;          
        }
        position={PositionCentered}
      >
        <ModalHeader 
          content@html={<h2>{title}</h2>} 
          requestClose={() -> showModal = false} 
        />
        {content}
        <ul>
          <li>
            <TextControl
              id="set-content"
              label="Set Content" 
              value={content} 
              onCommit={value -> content = value} 
            />
          </li>
        </ul>
      </Modal>
    </if>
  </>);

}
