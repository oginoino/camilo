import '../../common_libs.dart';

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
  int? _selectedPredictionAddressIndex;
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
    return Padding(
      padding: EdgeInsets.all(uiConstants.paddingMedium),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: uiConstants.paddingMedium),
          _buildSearchBar(context),
          _buildPredictionsList(),
          SizedBox(height: uiConstants.paddingMedium),
          _buildAdressesList(context),
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

  Widget _buildSearchBar(BuildContext context) {
    const String hintText = 'Digite o endereço de entrega';
    return Column(
      children: [
        SearchBar(
          leading: IconButton(
            icon: Icon(Icons.search,
                color: Theme.of(context).colorScheme.secondary),
            onPressed: () {},
            visualDensity: VisualDensity.compact,
          ),
          trailing: [
            IconButton(
              icon: Icon(Icons.close,
                  color: Theme.of(context).colorScheme.secondary),
              onPressed: () {
                searchAddressTextEditingController.clear();
                Provider.of<MapsService>(context, listen: false)
                    .clearPredictions();
                setState(
                  () => _selectedPredictionAddressIndex = null,
                );
              },
              visualDensity: VisualDensity.compact,
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
              const Duration(milliseconds: 1000),
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
                debugPrint('Debounced: $value');
              },
            );
          },
        ),
        SizedBox(height: uiConstants.paddingExtraSmall),
        const GoogleAtribuition()
      ],
    );
  }

  Widget _buildPredictionsList() {
    return Consumer<MapsService>(
      builder: (context, mapsApiService, child) {
        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (mapsApiService.predictions.predictions.isEmpty &&
            searchAddressTextEditingController.text.isNotEmpty) {
          return Center(
            child: Text(
              'Não encontramos nenhum endereço disponível para a busca informada.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return Column(
            children: [
              if (mapsApiService.predictions.predictions.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: uiConstants.paddingMedium,
                  ),
                  child: TextButton.icon(
                    onPressed: null,
                    icon: Icon(
                      Icons.add_location_alt_rounded,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    label: Text(
                      'Adicione um novo endereço',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: mapsApiService.predictions.predictions.length,
                itemBuilder: (context, index) {
                  final prediction =
                      mapsApiService.predictions.predictions[index];
                  return ListTile(
                    minVerticalPadding: 0,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      prediction.description,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    subtitle: const GoogleAtribuition(),
                    leading: Padding(
                      padding:
                          EdgeInsets.only(bottom: uiConstants.paddingMedium),
                      child: Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        value: _selectedPredictionAddressIndex == index,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(48),
                        ),
                        onChanged: (bool? selected) {
                          setState(() {
                            if (selected != null && selected) {
                              _selectedPredictionAddressIndex = index;
                            }
                          });
                        },
                      ),
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
                        _selectedPredictionAddressIndex = index;
                        session.userData?.addAddress(address);
                        session.selectAddress(address);
                      });
                      focusNode.unfocus();
                      appRouter.routerDelegate.popRoute();
                    },
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }

  _buildAdressesList(BuildContext context) {
    return Consumer<Session>(
      builder: (context, session, child) {
        if (session.userData?.addresses == null ||
            session.userData!.addresses!.isEmpty) {
          return const SizedBox.shrink();
        } else {
          final String? selectedAddressId = session.selectedAddress?.id;

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: uiConstants.paddingMedium,
                ),
                child: TextButton.icon(
                  icon: Icon(
                    Icons.bookmark_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: null,
                  label: Text(
                    'Selecione um endereço salvo',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: session.userData!.addresses!.length,
                itemBuilder: (context, index) {
                  final address = session.userData!.addresses![index];
                  // Verifique se este endereço deve estar selecionado
                  bool isSelected = address.id == selectedAddressId;
                  if (isSelected) {
                    _selectedAddressIndex =
                        index; // Atualize o índice selecionado
                  }

                  return ListTile(
                    minVerticalPadding: 0,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      address.description,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    leading: Padding(
                      padding:
                          EdgeInsets.only(bottom: uiConstants.paddingMedium),
                      child: Radio(
                        value: index,
                        groupValue: _selectedAddressIndex,
                        onChanged: (int? selected) {
                          setState(() {
                            if (selected != null) {
                              _selectedAddressIndex = selected;
                              session.selectAddress(address);
                            }
                          });
                        },
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedAddressIndex = index;
                        session.selectAddress(address);
                      });
                      appRouter.routerDelegate.popRoute();
                    },
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}

class GoogleAtribuition extends StatelessWidget {
  const GoogleAtribuition({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: uiConstants.paddingLarge,
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Image.asset(
          'assets/images/google/google_on_white.png',
          height: 18,
          width: 48,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
