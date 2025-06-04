# goblo-edms
고블로 AI 자동 문서 관리 시스템

## ROS2 Electric Switch Example

This repository contains a sample ROS2 node for remotely controlling an electric switch (`ros2_switch` directory) and a minimal Flutter interface (`flutter_switch_app` directory).

### ROS2 Setup

Make sure ROS2 Foxy or later is installed. Build the package using `colcon`:

```bash
source /opt/ros/foxy/setup.bash
colcon build --packages-select ros2_switch
```

Run the switch node:

```bash
. install/setup.bash
ros2 run ros2_switch switch_node
```

The node listens to the `switch_cmd` topic (`std_msgs/Bool`) and logs the ON/OFF state.

### Flutter Interface

The Flutter example publishes messages to a WebSocket ROS bridge (e.g. `rosbridge_server`). Update the WebSocket URL in `lib/main.dart` if necessary.

To run the Flutter app:

```bash
cd flutter_switch_app
flutter pub get
flutter run
```
