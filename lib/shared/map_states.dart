enum MapState {
    pickup(
      val: 'Pickup',
      modes: ['New', 'Active', 'History'],
    ),
    delivery(
      val: 'Delivery',
      modes: ['Pending', 'Delivered', 'All']
    );

    const MapState ({
      required this.val,
      required this.modes,
    });

    final String val;
    final List<String> modes;
}