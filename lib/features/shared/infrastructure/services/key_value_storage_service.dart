abstract class KeyValueStorageService {
  // metodo recive un generico y retorna ese mismo tipo de dato. String, Double, Bool ...etc
  Future<void> setKeyValue<T>(String key, T value);
  // metodo recive un generico y retorna ese mismo tipo de dato opcional "Puede que la key solicitada no exista". String?, Double?, Bool? ...etc
  Future<T?> getKeyValue<T>(String key);
  // retorna un bool si se elimino la key o no.
  Future<bool> removeKey(String key);
}
