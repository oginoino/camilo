import '../common_libs.dart';

class ProductsService with ChangeNotifier {
  List<Product> productListService = [
    Product(
      id: '1',
      productName: 'Banana nanica seis unidades',
      productPrice: 2.99,
      productUnitOfMeasure: 'pack',
      productUnitQuantity: '1',
      productImageSrc:
          'https://acdn.mitiendanube.com/stores/001/254/392/products/frutas_hortifruti_hortifit_delivery_banana-prata1-860e400e9aee2c4e5a16922230786998-1024-1024.png',
      productCategories: ['Frutas', 'Promoções'],
      availableQuantity: 10,
      contentValue: '1kg',
    ),
    Product(
      id: '2',
      productName: 'Maçã Fuji Golden vermelha',
      productPrice: 3.99,
      productUnitOfMeasure: 'unidade(s)',
      productUnitQuantity: '1',
      productImageSrc:
          'https://acdn.mitiendanube.com/stores/001/254/392/products/frutas_hortifruti_hortifit_delivery_maca_red1-7cc45afdb5df004f1d16922896021639-640-0.png',
      productCategories: ['Frutas'],
      availableQuantity: 8,
      contentValue: '500g',
    ),
    Product(
      id: '3',
      productName: 'Pera  D\'Anjou',
      productPrice: 4.99,
      productUnitOfMeasure: 'unidade(s)',
      productUnitQuantity: '1',
      productImageSrc:
          'https://phygital-files.mercafacil.com/fazfeira/uploads/produto/pera_d_anjou_kg_7aa5c892-1f31-4a0f-a791-59f4e0429c2f.png',
      productCategories: ['Frutas'],
      availableQuantity: 5,
      contentValue: '100g',
    ),
    Product(
      id: '4',
      productName: 'Abacaxi pérola unidade',
      productPrice: 5.99,
      productUnitOfMeasure: 'unidadade(s)',
      productUnitQuantity: '1',
      productImageSrc:
          'https://www.hortifrutinovohorizonte.com.br/image/cache/catalog/frutas/abacaxi-caixa-c-10-unidades-800x800.png',
      productCategories: ['Frutas'],
      availableQuantity: 3,
      contentValue: '1kg',
    ),
    Product(
      id: '5',
      productName: 'Melancia grande 5kg a 6kg',
      productPrice: 6.99,
      productUnitOfMeasure: 'unidadade(s)',
      productUnitQuantity: '1',
      productImageSrc:
          'https://tdc01z.vteximg.com.br/arquivos/ids/161989-292-292/melancia-granel-21464.png?v=638067865344730000',
      productCategories: ['Frutas'],
      availableQuantity: 2,
      contentValue: '5kg a 6kg',
    ),
    Product(
      id: '6',
      productName: 'Uva thompson verde sem semente 500g',
      productPrice: 7.99,
      productUnitOfMeasure: 'cacho(s)',
      productUnitQuantity: '1',
      productImageSrc:
          'https://superprix.vteximg.com.br/arquivos/ids/176012-210-210/Uva-Thompson-Verde-sem-semente-500g--Bandeja-.png?v=636414113862070000',
      productCategories: ['Frutas', 'Promoções'],
      availableQuantity: 12,
      contentValue: '250g',
    ),
    Product(
      id: '7',
      productName: 'Laranja pera com 6 unidades',
      productPrice: 8.99,
      productUnitOfMeasure: 'unidades(s)',
      productUnitQuantity: '6',
      productImageSrc:
          'https://acdn.mitiendanube.com/stores/001/254/392/products/frutas_hortifruti_hortifit_delivery_laranja-pera1-2474be1e3e6ee53e2f16926317496643-480-0.png',
      productCategories: ['Frutas'],
      availableQuantity: 6,
      contentValue: '1kg',
    ),
    Product(
      id: '8',
      productName: 'Morango bandeja 250g',
      productPrice: 9.99,
      productUnitOfMeasure: 'pack',
      productUnitQuantity: '1',
      productImageSrc:
          'https://cdn.lojazmart.com/media/catalog/product/cache/1/image/363x/040ec09b1e35df139433887a97daa66f/m/o/morango_zmart.png',
      productCategories: ['Frutas', 'Doces'],
      availableQuantity: 4,
      contentValue: '250g',
    ),
    Product(
      id: '9',
      productName: 'Sorvete Ben & Jerry\'s 458ml',
      productPrice: 52.99,
      productUnitOfMeasure: 'pote',
      productUnitQuantity: '1',
      productImageSrc:
          'https://www.benandjerry.com.br/files/live/sites/systemsite/files/flavors/products/br/pints/open-closed-pints/doce-deleite-core-landing.png',
      productCategories: ['Doces', 'Promoções'],
      availableQuantity: 1,
      contentValue: '458ml',
    ),
    Product(
      id: '10',
      productName: 'Coca-Cola lata Original 350ml',
      productPrice: 2.99,
      productUnitOfMeasure: 'unidade(s)',
      productUnitQuantity: '1',
      productImageSrc:
          'https://supermercadobomdemais.com.br/wp-content/uploads/2020/05/Refrigerante-Coca-Cola-220.png',
      productCategories: ['Doces', 'Bebidas', 'Promoções'],
      availableQuantity: 7,
      contentValue: '350ml',
    ),
  ];
}
