import Link from "@docusaurus/Link";
import useDocusaurusContext from "@docusaurus/useDocusaurusContext";
import Heading from "@theme/Heading";
import Layout from "@theme/Layout";
import clsx from "clsx";

import styles from "./index.module.css";

export default function Home(): JSX.Element {
	const { siteConfig } = useDocusaurusContext();
	return (
		<Layout
			title={`${siteConfig.title}`}
			description="Description will go into a meta tag in <head />"
		>
			<Header />
			<main>
				<Features />
			</main>
		</Layout>
	);
}

function Header() {
	const { siteConfig } = useDocusaurusContext();
	return (
		<header className={clsx("hero hero--primary", styles.heroBanner)}>
			<div className="container">
				<Heading as="h1" className="hero__title">
					{siteConfig.title}
				</Heading>
				<p className="hero__subtitle">{siteConfig.tagline}</p>
				<div className={styles.buttons}>
					<Link
						className="button button--secondary button--lg"
						to="/introduction"
					>
						Introduction
					</Link>
				</div>
			</div>
		</header>
	);
}

const Features = (): JSX.Element => {
	return (
		<section className={styles.features}>
			<div className="container">
				<div className="row">
					{FeatureList.map((feature) => (
						<Feature key={feature.title} {...feature} />
					))}
				</div>
			</div>
		</section>
	);
};

const Feature = ({ title, to, Svg, description }: FeatureItem) => {
	return (
		<div className={clsx("col col--4")}>
			<Link to={to}>
				<div className="text--center">
					<Svg className={styles.featureSvg} role="img" />
				</div>
				<div className="text--center padding-horiz--md">
					<Heading as="h3">{title}</Heading>
					<p>{description}</p>
				</div>
			</Link>
		</div>
	);
};

type FeatureItem = {
	title: string;
	to: string;
	Svg: React.ComponentType<React.ComponentProps<"svg">>;
	description: JSX.Element;
};

const FeatureList: FeatureItem[] = [
	{
		title: "Tutorials",
		to: "/tutorials",
		Svg: require("@site/static/img/undraw_docusaurus_mountain.svg").default,
		description: <></>,
	},
	{
		title: "DevOps",
		to: "/devops",
		Svg: require("@site/static/img/undraw_docusaurus_tree.svg").default,
		description: <></>,
	},
	{
		title: "Plugin Functions",
		to: "/plugin-functions",
		Svg: require("@site/static/img/undraw_docusaurus_react.svg").default,
		description: <></>,
	},
	{
		title: "Resources",
		to: "/resources",
		Svg: require("@site/static/img/undraw_docusaurus_react.svg").default,
		description: <></>,
	},
];
