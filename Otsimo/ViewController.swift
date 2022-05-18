import UIKit

class ViewController: UIViewController {
    private let animationHelper = AnimationHelper()
    private var pokemonViewModel = PokemonViewModel()
    private var pokemonNumber = 2
    
    private var containerViewFront = UIView()
    private var imageViewFront = UIImageView()
    private var containerViewBack = UIView()
    private var imageViewBack = UIImageView()

    private var hpLabelFront = UILabel()
    private var attackLabelFront = UILabel()
    private var defenceLabelFront = UILabel()
    private var hpFront = UILabel()
    private var attackFront = UILabel()
    private var defenceFront = UILabel()

    private var hpLabelBack = UILabel()
    private var attackLabelBack = UILabel()
    private var defenceLabelBack = UILabel()
    private var hpBack = UILabel()
    private var attackBack = UILabel()
    private var defenceBack = UILabel()

    private var pokemonNameFront = UILabel()
    private var pokemonNameBack = UILabel()
    
    private var reloadButton = UIImageView()
    
    private var loadingLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 172 / 255.0, green: 158 / 255.0, blue: 255 / 255.0, alpha: 1.0)
        containerViewFront.addSubview(imageViewFront)
        containerViewFront.addSubview(hpLabelFront)
        containerViewFront.addSubview(attackLabelFront)
        containerViewFront.addSubview(defenceLabelFront)
        containerViewFront.addSubview(hpFront)
        containerViewFront.addSubview(attackFront)
        containerViewFront.addSubview(defenceFront)
        containerViewFront.addSubview(pokemonNameFront)
        containerViewBack.addSubview(loadingLabel)
        
        containerViewBack.addSubview(imageViewBack)
        containerViewBack.addSubview(hpLabelBack)
        containerViewBack.addSubview(attackLabelBack)
        containerViewBack.addSubview(defenceLabelBack)
        containerViewBack.addSubview(hpBack)
        containerViewBack.addSubview(attackBack)
        containerViewBack.addSubview(defenceBack)
        containerViewBack.addSubview(pokemonNameBack)
        
        view.addSubview(containerViewFront)
        view.addSubview(containerViewBack)
        view.addSubview(reloadButton)
        
        setupLayout()
        
        let frontCardRecognizer = UITapGestureRecognizer(target: self, action: #selector(frontCardTapped))
        let backCardRecognizer = UITapGestureRecognizer(target: self, action: #selector(backCardTapped))
        let reloadButtonRecognizer = UITapGestureRecognizer(target: self, action: #selector(reloadTapped))
        containerViewFront.isUserInteractionEnabled = true
        containerViewBack.isUserInteractionEnabled = true
        reloadButton.isUserInteractionEnabled = true
        containerViewFront.addGestureRecognizer(frontCardRecognizer)
        containerViewBack.addGestureRecognizer(backCardRecognizer)
        reloadButton.addGestureRecognizer(reloadButtonRecognizer)
        
        pokemonViewModel.fetchItems {
            self.initializeView()
        }
    }
    
    @objc func frontCardTapped(_ sender:UIButton){
        self.animationHelper.firstAnimation(frontView: containerViewFront, backView: containerViewBack) {
            let pokemon = self.pokemonViewModel.pokemonListWithDetails[self.pokemonNumber]
            if let hp = pokemon.detail.stats?[0].baseStat {
                self.hpFront.text = String(hp)
            }
            if let attack = pokemon.detail.stats?[1].baseStat {
                self.attackFront.text = String(attack)
            }
            if let defence = pokemon.detail.stats?[2].baseStat {
                self.defenceFront.text = String(defence)
            }
            self.pokemonNameFront.text = pokemon.name
            if let imageString = pokemon.detail.sprites?.frontDefault {
                if let imageUrl = URL(string: imageString) {
                    if let data = try? Data(contentsOf: imageUrl) {
                        if let image = UIImage(data: data) {
                            self.imageViewFront.image = image
                        }
                    }
                }
            }
        }
        pokemonNumber += 1
        
    }
    @objc func backCardTapped(_ sender:UIButton){
        self.animationHelper.secondAnimation(frontView: containerViewBack, backView: containerViewFront) {
            let pokemon = self.pokemonViewModel.pokemonListWithDetails[self.pokemonNumber]
            if let hp = pokemon.detail.stats?[0].baseStat {
                self.hpBack.text = String(hp)
            }
            if let attack = pokemon.detail.stats?[1].baseStat {
                self.attackBack.text = String(attack)
            }
            if let defence = pokemon.detail.stats?[2].baseStat {
                self.defenceBack.text = String(defence)
            }
            self.pokemonNameBack.text = pokemon.name
            if let imageString = pokemon.detail.sprites?.frontDefault {
                if let imageUrl = URL(string: imageString) {
                    if let data = try? Data(contentsOf: imageUrl) {
                        if let image = UIImage(data: data) {
                            self.imageViewBack.image = image
                        }
                    }
                }
            }
        }
        pokemonNumber += 1
    }
    @objc func reloadTapped(_ sender: UIButton) {
        pokemonNumber = 2
        self.initializeView()
        
    }
    private func initializeView() {
        hpLabelFront.text = "hp"
        attackLabelFront.text = "attack"
        defenceLabelFront.text = "defence"
        hpLabelBack.text = "hp"
        attackLabelBack.text = "attack"
        defenceLabelBack.text = "defence"
        loadingLabel.text = ""
        containerViewBack.isHidden = true
        containerViewFront.isHidden = false
        let pokemon = self.pokemonViewModel.pokemonListWithDetails[0]
        if let hp = pokemon.detail.stats?[0].baseStat {
            hpFront.text = String(hp)
        }
        if let attack = pokemon.detail.stats?[1].baseStat {
            attackFront.text = String(attack)
        }
        if let defence = pokemon.detail.stats?[2].baseStat {
            defenceFront.text = String(defence)
        }
        self.pokemonNameFront.text = pokemon.name
        if let imageString = pokemon.detail.sprites?.frontDefault {
            if let imageUrl = URL(string: imageString) {
                if let data = try? Data(contentsOf: imageUrl) {
                    if let image = UIImage(data: data) {
                        self.imageViewFront.image = image
                    }
                }
            }
        }
        let pokemon2 = self.pokemonViewModel.pokemonListWithDetails[1]
        if let hp2 = pokemon2.detail.stats?[0].baseStat {
            hpBack.text = String(hp2)
        }
        if let attack2 = pokemon2.detail.stats?[1].baseStat {
            attackBack.text = String(attack2)
        }
        if let defence2 = pokemon2.detail.stats?[2].baseStat {
            defenceBack.text = String(defence2)
        }
        self.pokemonNameBack.text = pokemon2.name
        if let imageString2 = pokemon2.detail.sprites?.frontDefault {
            if let imageUrl2 = URL(string: imageString2) {
                if let data2 = try? Data(contentsOf: imageUrl2) {
                    if let image2 = UIImage(data: data2) {
                        self.imageViewBack.image = image2
                    }
                }
            }
        }
    }
    
    private func setupLayout() {
        loadingLabel.text = "Loading..."
        
        hpFront.font = UIFont.systemFont(ofSize: 32)
        attackFront.font = UIFont.systemFont(ofSize: 32)
        defenceFront.font = UIFont.systemFont(ofSize: 32)
        hpLabelFront.font = UIFont.systemFont(ofSize: 18)
        attackLabelFront.font = UIFont.systemFont(ofSize: 18)
        defenceLabelFront.font = UIFont.systemFont(ofSize: 18)
        hpBack.font = UIFont.systemFont(ofSize: 32)
        attackBack.font = UIFont.systemFont(ofSize: 32)
        defenceBack.font = UIFont.systemFont(ofSize: 32)
        hpLabelBack.font = UIFont.systemFont(ofSize: 18)
        attackLabelBack.font = UIFont.systemFont(ofSize: 18)
        defenceLabelBack.font = UIFont.systemFont(ofSize: 18)
        pokemonNameFront.font = UIFont.systemFont(ofSize: 24)
        pokemonNameBack.font = UIFont.systemFont(ofSize: 24)
        loadingLabel.font = UIFont.systemFont(ofSize: 24)
        
        attackFront.textAlignment = .center
        hpFront.textAlignment = .center
        defenceFront.textAlignment = .center
        attackLabelFront.textAlignment = .center
        hpLabelFront.textAlignment = .center
        defenceLabelFront.textAlignment = .center
        hpBack.textAlignment = .center
        attackBack.textAlignment = .center
        defenceBack.textAlignment = .center
        hpLabelBack.textAlignment = .center
        attackLabelBack.textAlignment = .center
        defenceLabelBack.textAlignment = .center
        pokemonNameFront.textAlignment = .center
        pokemonNameBack.textAlignment = .center
        loadingLabel.textAlignment = .center
        
        containerViewFront.translatesAutoresizingMaskIntoConstraints = false
        containerViewFront.backgroundColor = .white
        containerViewBack.translatesAutoresizingMaskIntoConstraints = false
        containerViewBack.backgroundColor = .white
        imageViewFront.translatesAutoresizingMaskIntoConstraints = false
        imageViewBack.translatesAutoresizingMaskIntoConstraints = false
        hpFront.translatesAutoresizingMaskIntoConstraints = false
        attackFront.translatesAutoresizingMaskIntoConstraints = false
        defenceFront.translatesAutoresizingMaskIntoConstraints = false
        hpLabelFront.translatesAutoresizingMaskIntoConstraints = false
        attackLabelFront.translatesAutoresizingMaskIntoConstraints = false
        defenceLabelFront.translatesAutoresizingMaskIntoConstraints = false
        hpBack.translatesAutoresizingMaskIntoConstraints = false
        attackBack.translatesAutoresizingMaskIntoConstraints = false
        defenceBack.translatesAutoresizingMaskIntoConstraints = false
        hpLabelBack.translatesAutoresizingMaskIntoConstraints = false
        attackLabelBack.translatesAutoresizingMaskIntoConstraints = false
        defenceLabelBack.translatesAutoresizingMaskIntoConstraints = false
        pokemonNameFront.translatesAutoresizingMaskIntoConstraints = false
        pokemonNameBack.translatesAutoresizingMaskIntoConstraints = false
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        loadingLabel.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 226).isActive = true
        loadingLabel.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -225).isActive = true
        loadingLabel.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 30).isActive = true
        loadingLabel.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -30).isActive = true
        
        reloadButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 48).isActive = true
        reloadButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -748).isActive = true
        reloadButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        reloadButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -326).isActive = true
        reloadButton.image = UIImage(named: "reload")
        reloadButton.contentMode = .scaleAspectFit
        
        pokemonNameFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 18).isActive = true
        pokemonNameFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -433).isActive = true
        pokemonNameFront.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 30).isActive = true
        pokemonNameFront.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -30).isActive = true
        
        pokemonNameBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 18).isActive = true
        pokemonNameBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -433).isActive = true
        pokemonNameBack.leftAnchor.constraint(equalTo: containerViewBack.leftAnchor, constant: 30).isActive = true
        pokemonNameBack.rightAnchor.constraint(equalTo: containerViewBack.rightAnchor, constant: -30).isActive = true
        
        containerViewFront.topAnchor.constraint(equalTo: view.topAnchor, constant: 182).isActive = true
        containerViewFront.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -182).isActive = true
        containerViewFront.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 45).isActive = true
        containerViewFront.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -45).isActive = true
        
        imageViewFront.frame = CGRect(x: 0, y: 0, width: 101.95, height: 114)
        imageViewFront.contentMode = .scaleAspectFill
        imageViewFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 183).isActive = true
        imageViewFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -183).isActive = true
        imageViewFront.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 99).isActive = true
        imageViewFront.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -99).isActive = true
        
        containerViewBack.topAnchor.constraint(equalTo: view.topAnchor, constant: 182).isActive = true
        containerViewBack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -182).isActive = true
        containerViewBack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 45).isActive = true
        containerViewBack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -45).isActive = true
        
        imageViewBack.frame = CGRect(x: 0, y: 0, width: 101.95, height: 114)
        imageViewBack.contentMode = .scaleAspectFill
        imageViewBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 183).isActive = true
        imageViewBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -183).isActive = true
        imageViewBack.leftAnchor.constraint(equalTo: containerViewBack.leftAnchor, constant: 99).isActive = true
        imageViewBack.rightAnchor.constraint(equalTo: containerViewBack.rightAnchor, constant: -99).isActive = true
        
        hpFront.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 18).isActive = true
        hpFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -23).isActive = true
        hpFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 419).isActive = true
        hpFront.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -194).isActive = true
        
        hpLabelFront.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 18).isActive = true
        hpLabelFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -61).isActive = true
        hpLabelFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 398).isActive = true
        hpLabelFront.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -194).isActive = true
        
        attackFront.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 106).isActive = true
        attackFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -23).isActive = true
        attackFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 419).isActive = true
        attackFront.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -106).isActive = true
        
        attackLabelFront.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 106).isActive = true
        attackLabelFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -61).isActive = true
        attackLabelFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 398).isActive = true
        attackLabelFront.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -106).isActive = true
        
        defenceFront.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 194).isActive = true
        defenceFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -23).isActive = true
        defenceFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 419).isActive = true
        defenceFront.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -18).isActive = true
        
        defenceLabelFront.leftAnchor.constraint(equalTo: containerViewFront.leftAnchor, constant: 194).isActive = true
        defenceLabelFront.bottomAnchor.constraint(equalTo: containerViewFront.bottomAnchor, constant: -61).isActive = true
        defenceLabelFront.topAnchor.constraint(equalTo: containerViewFront.topAnchor, constant: 398).isActive = true
        defenceLabelFront.rightAnchor.constraint(equalTo: containerViewFront.rightAnchor, constant: -18).isActive = true
        
        hpBack.leftAnchor.constraint(equalTo: containerViewBack.leftAnchor, constant: 18).isActive = true
        hpBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -23).isActive = true
        hpBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 419).isActive = true
        hpBack.rightAnchor.constraint(equalTo: containerViewBack.rightAnchor, constant: -194).isActive = true
        
        hpLabelBack.leftAnchor.constraint(equalTo: containerViewBack.leftAnchor, constant: 18).isActive = true
        hpLabelBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -61).isActive = true
        hpLabelBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 398).isActive = true
        hpLabelBack.rightAnchor.constraint(equalTo: containerViewBack.rightAnchor, constant: -194).isActive = true
        
        attackBack.leftAnchor.constraint(equalTo: containerViewBack.leftAnchor, constant: 106).isActive = true
        attackBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -23).isActive = true
        attackBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 419).isActive = true
        attackBack.rightAnchor.constraint(equalTo: containerViewBack.rightAnchor, constant: -106).isActive = true
        
        attackLabelBack.leftAnchor.constraint(equalTo: containerViewBack.leftAnchor, constant: 106).isActive = true
        attackLabelBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -61).isActive = true
        attackLabelBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 398).isActive = true
        attackLabelBack.rightAnchor.constraint(equalTo: containerViewBack.rightAnchor, constant: -106).isActive = true
        
        defenceBack.leftAnchor.constraint(equalTo: containerViewBack.leftAnchor, constant: 194).isActive = true
        defenceBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -23).isActive = true
        defenceBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 419).isActive = true
        defenceBack.rightAnchor.constraint(equalTo: containerViewBack.rightAnchor, constant: -18).isActive = true
        
        defenceLabelBack.leftAnchor.constraint(equalTo: containerViewBack.leftAnchor, constant: 194).isActive = true
        defenceLabelBack.bottomAnchor.constraint(equalTo: containerViewBack.bottomAnchor, constant: -61).isActive = true
        defenceLabelBack.topAnchor.constraint(equalTo: containerViewBack.topAnchor, constant: 398).isActive = true
        defenceLabelBack.rightAnchor.constraint(equalTo: containerViewBack.rightAnchor, constant: -18).isActive = true
        
        containerViewFront.layer.cornerRadius = 36
        containerViewBack.layer.cornerRadius = 36
        
    }
}

