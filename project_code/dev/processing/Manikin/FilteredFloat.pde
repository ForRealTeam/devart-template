class FilteredFloat {
  private float value;
  private float smoothing;
  
  FilteredFloat(FilteredFloat other) {
    this.value = other.value;
    this.smoothing = other.smoothing;
  }

  FilteredFloat(float smoothing) {
    this.smoothing = smoothing;
  }

  void put(float v) {
    value = smoothing * value + (1-smoothing) * v;
  }

  void put(FilteredFloat ff) {
    value = smoothing * value + (1-smoothing) * ff.get();
  }

  float get() {
    return value;
  }
  
  void set(float v) {
    value = v;
  }

  void set(FilteredFloat ff) {
    value = ff.get();
  }
  
  boolean similar(FilteredFloat other, int tolerance) {
    return abs(get() - other.get()) < tolerance; 
  }
  
  public String toString() {
    return value + "(" + smoothing + ")";
  }
}

