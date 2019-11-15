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
        </PortalProvider>
      </>)
    );
  }

}

class ModalTest extends Component {

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
        <ModalHeader title="Example" requestClose={() -> showModal = false} />
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
