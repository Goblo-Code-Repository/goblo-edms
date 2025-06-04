import rclpy
from rclpy.node import Node
from std_msgs.msg import Bool

class SwitchNode(Node):
    def __init__(self):
        super().__init__('switch_node')
        self.switch_state = False
        self.subscription = self.create_subscription(
            Bool,
            'switch_cmd',
            self.switch_callback,
            10
        )

    def switch_callback(self, msg: Bool):
        self.switch_state = msg.data
        if self.switch_state:
            self.get_logger().info('Switch ON')
        else:
            self.get_logger().info('Switch OFF')

def main(args=None):
    rclpy.init(args=args)
    node = SwitchNode()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
