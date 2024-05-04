import '../../common_libs.dart';
import '../../models/address.dart';

class SearchAddressBottomSheet extends StatefulWidget {
  const SearchAddressBottomSheet({super.key});

  @override
  SearchAddressBottomSheetState createState() =>
      SearchAddressBottomSheetState();
}

class SearchAddressBottomSheetState extends State<SearchAddressBottomSheet> {
  final TextEditingController searchAddressTextEditingController =
      TextEditingController();
  final FocusNode focusNode = FocusNode();
  Timer? _debounce;
  bool _isLoading = false;
  int? _selectedAddressIndex;

  @override
  void dispose() {
    searchAddressTextEditingController.dispose();
    mapsApiService.predictions.predictions.clear();
    focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String hintText = 'Digite o endereço de entrega';
    return Padding(
      padding: EdgeInsets.all(uiConstants.paddingMedium),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: uiConstants.paddingMedium),
          _buildSearchBar(context, hintText),
          SizedBox(height: uiConstants.paddingMedium),
          Expanded(child: _buildPredictionsList()),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.location_on_rounded,
            color: Theme.of(context).colorScheme.secondary),
        SizedBox(width: uiConstants.paddingSmall),
        Text(
          'Endereço de entrega',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context, String hintText) {
    return SearchBar(
      leading: IconButton(
        icon:
            Icon(Icons.search, color: Theme.of(context).colorScheme.secondary),
        onPressed: () {},
      ),
      trailing: [
        IconButton(
          icon:
              Icon(Icons.close, color: Theme.of(context).colorScheme.secondary),
          onPressed: () {
            searchAddressTextEditingController.clear();
            Provider.of<MapsService>(context, listen: false).clearPredictions();
            setState(
              () => _selectedAddressIndex = null,
            );
          },
        ),
      ],
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      focusNode: focusNode,
      controller: searchAddressTextEditingController,
      hintText: hintText,
      onSubmitted: (value) {
        focusNode.unfocus();
      },
      onChanged: (value) {
        _debounce?.cancel();
        _debounce = Timer(
          const Duration(milliseconds: 500),
          () {
            if (value.isNotEmpty && value.length > 5) {
              setState(() {
                _isLoading = true;
              });
              Provider.of<MapsService>(context, listen: false)
                  .fetchAddress(value)
                  .then((_) {
                setState(() {
                  _isLoading = false;
                });
              });
            }
          },
        );
      },
    );
  }

  Widget _buildPredictionsList() {
    return Consumer<MapsService>(
      builder: (context, mapsApiService, child) {
        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (mapsApiService.predictions.predictions.isEmpty) {
          return const Center(child: Text("Nenhum endereço encontrado."));
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: mapsApiService.predictions.predictions.length,
            itemBuilder: (context, index) {
              final prediction = mapsApiService.predictions.predictions[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  prediction.description,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                leading: Checkbox(
                  value: _selectedAddressIndex == index,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48),
                  ),
                  onChanged: (bool? selected) {
                    setState(() {
                      if (selected != null && selected) {
                        _selectedAddressIndex =
                            index; // Atualiza o índice selecionado
                      }
                    });
                  },
                ),
                onTap: () {
                  final address = Address(
                    id: prediction.placeId,
                    description: prediction.description,
                    mainText: prediction.structuredFormatting.mainText,
                    secondaryText:
                        prediction.structuredFormatting.secondaryText,
                  );
                  searchAddressTextEditingController.text =
                      prediction.description;
                  setState(() {
                    _selectedAddressIndex = index;
                    session.user?.addAddress(address);
                    session.selectAddress(address);
                  });
                },
              );
            },
          );
        }
      },
    );
  }
}
