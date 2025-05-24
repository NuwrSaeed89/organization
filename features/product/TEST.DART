CarouselSlider.builder(
  itemCount: items.length,
  carouselController: carouselController,
  options: CarouselOptions(
    enlargeCenterPage: true, // يجعل السلايد النشط أكبر
    viewportFraction: 0.8, // يتحكم في حجم السلايدات الأخرى
    autoPlay: true, 
    autoPlayCurve: Curves.fastOutSlowIn, // منحنى الحركة المناسب
    autoPlayAnimationDuration: Duration(milliseconds: 800), // مدة التأثير
  ),
  itemBuilder: (context, index, realIndex) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
      transform: Matrix4.identity()..scale(index == realIndex ? 1.1 : 0.9), // تكبير السلايد الحالي وتصغير الآخرين
      child: Image.asset(items[index], fit: BoxFit.cover),
    );
  },
)
CarouselSlider.builder(
  itemCount: items.length,
  carouselController: carouselController,
  options: CarouselOptions(
    viewportFraction: 0.8, // تحديد عرض السلايدات الأخرى
    autoPlay: true,
    autoPlayCurve: Curves.fastOutSlowIn,
    autoPlayAnimationDuration: Duration(milliseconds: 800),
  ),
  itemBuilder: (context, index, realIndex) {
    return AnimatedBuilder(
      animation: carouselController,
      builder: (context, child) {
        double scale = realIndex == index ? 1.1 : 0.9; // تكبير السلايد الحالي تدريجيًا
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: Image.asset(items[index], fit: BoxFit.cover),
    );
  },
)
