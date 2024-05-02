import '../../services/maps_service.dart';
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

  @override
  void dispose() {
    searchAddressTextEditingController.dispose();
    focusNode.dispose();
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
          onPressed: () => searchAddressTextEditingController.clear(),
        ),
      ],
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      focusNode: focusNode,
      controller: searchAddressTextEditingController,
      hintText: hintText,
      onSubmitted: (value) => focusNode.unfocus(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          Provider.of<MapsService>(context, listen: false).fetchAddress(value);
        }
      },
    );
  }

  Widget _buildPredictionsList() {
    return Consumer<MapsService>(
      builder: (context, apiService, child) {
        if (apiService.predictions.predictions.isEmpty) {
          return const Center(child: Text("Nenhum endereço encontrado."));
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: apiService.predictions.predictions.length,
          itemBuilder: (context, index) {
            final prediction = apiService.predictions.predictions[index];
            return ListTile(
              title: Text(prediction.description),
              onTap: () {
                searchAddressTextEditingController.text =
                    prediction.description;
              },
            );
          },
        );
      },
    );
  }
}
